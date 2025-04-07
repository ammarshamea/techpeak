import 'package:dartz/dartz.dart';
import 'package:techpeak/core/function/network_connection.dart';
import 'package:techpeak/features/terms_and_conditions/data/datasources/local_terms_data_source.dart';
import 'package:techpeak/features/terms_and_conditions/data/datasources/remote_terms_data_source.dart';
import 'package:techpeak/features/terms_and_conditions/domain/entities/term_and_conditions.dart';
import 'package:techpeak/features/terms_and_conditions/domain/repositories/terms_repositories.dart';

class TermsRepositoriesImpl implements TermsRepositories {
  final LocalTermsDataSource localDataSource;
  final RemoteTermsDataSource remoteDataSource;
  final NetworkConnection networkConnection;

  TermsRepositoriesImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkConnection,
  });

  @override
  Future<Either<Map<String, dynamic>, List<TermAndConditions>>> getTerms() async {
    try {
      if (await networkConnection.isConnected) {
        // Try to get terms from remote
        try {
          final remoteTerms = await remoteDataSource.getTerms();
          // Cache the terms locally
          await localDataSource.cacheTerms(remoteTerms);
          return Right(remoteTerms);
        } catch (e) {
          // If remote fails, try to get cached terms
          try {
            final cachedTerms = await localDataSource.getTerms();
            return Right(cachedTerms);
          } catch (e) {
            return Left({
              'error': 'No cached terms available',
              'message': 'Please check your internet connection and try again',
            });
          }
        }
      } else {
        // If offline, try to get cached terms
        try {
          final cachedTerms = await localDataSource.getTerms();
          return Right(cachedTerms);
        } catch (e) {
          return Left({
            'error': 'Offline',
            'message': 'No internet connection and no cached terms available',
          });
        }
      }
    } catch (e) {
      return Left({
        'error': 'Unknown error',
        'message': e.toString(),
      });
    }
  }


  @override
  bool checkTermsAcceptance(bool accepted) {
    return remoteDataSource.checkTermsAcceptance(accepted);
  }
} 