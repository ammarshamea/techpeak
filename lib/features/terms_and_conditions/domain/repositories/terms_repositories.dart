import 'package:dartz/dartz.dart';
import '../entities/term_and_conditions.dart';

abstract class TermsRepositories {

  Future<Either<Map<String, dynamic>, List<TermAndConditions>>> getTerms();

  bool checkTermsAcceptance(bool accepted);
  

}