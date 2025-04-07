import 'dart:convert';
import 'package:techpeak/core/sharedprefrence/shared_prefrence.dart';
import '../models/term_and_conditions_model.dart';
import 'terms_data_source.dart';

abstract class LocalDataSourceTerms {
  Future<List<TermAndConditionsModel>> getTerms();
  Future<void> cacheTerms(List<TermAndConditionsModel> terms);

}

class LocalTermsDataSource implements LocalDataSourceTerms {
  final MyServices _myServices;
  static const String _termsKey = 'cached_terms';

  LocalTermsDataSource(this._myServices);

  @override
  Future<List<TermAndConditionsModel>> getTerms() async {
    final String? cachedTerms =await
        _myServices.sharedGet<String> (key:  _termsKey);

    if (cachedTerms != null) {
      return [TermAndConditionsModel.fromJson(
        json.decode(cachedTerms) as Map<String, dynamic>,
      )];
    }

    throw Exception('No cached terms found');
  }

  @override
  Future<void> cacheTerms(List<TermAndConditionsModel> terms) async {
    final cached=terms.map((json)=>json.toJson()).toList();
    await _myServices.sharedSet(
      key: _termsKey,
      value: json.encode(cached),
    );
  }



}
