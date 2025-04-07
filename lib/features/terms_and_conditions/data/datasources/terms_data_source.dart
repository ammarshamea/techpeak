import '../models/term_and_conditions_model.dart';

abstract class TermsDataSource {
  Future<List<TermAndConditionsModel>> getTerms();

  bool checkTermsAcceptance(bool accepted);
}
