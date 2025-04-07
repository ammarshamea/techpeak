import 'package:dartz/dartz.dart';
import '../entities/term_and_conditions.dart';
import '../repositories/terms_repositories.dart';

class TermsUseCase {
  final TermsRepositories _termsRepositories;

  TermsUseCase(this._termsRepositories);

  Future<Either<Map<String, dynamic>, List<TermAndConditions>>> callTerms() async {
    return await _termsRepositories.getTerms();
  }



  bool checkTermsAcceptance(bool accepted) {
    return _termsRepositories.checkTermsAcceptance(accepted);
  }
}