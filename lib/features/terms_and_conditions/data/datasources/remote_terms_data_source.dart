import 'package:dio/dio.dart';
import 'package:techpeak/core/api_helper/api_helper.dart';
import 'package:techpeak/core/constante/app_key.dart';
import '../models/term_and_conditions_model.dart';
import 'terms_data_source.dart';
import 'package:techpeak/dependency_injection.dart';

class RemoteTermsDataSource implements TermsDataSource {
  final Dio dio;

  RemoteTermsDataSource(this.dio);

  @override
  Future<List<TermAndConditionsModel>> getTerms() async {
    try {
      final response = await sl<ApiHelper>()
          .requestApi(DataKey.termsAndConditions, ApiService.get);
      List data = response["data"];
      List<TermAndConditionsModel> terms = data
          .map<TermAndConditionsModel>(
              (json) => TermAndConditionsModel.fromJson(json))
          .toList();
      return terms;
    } catch (e) {
      throw Exception('Failed to load terms');
    }
  }

  @override
  bool checkTermsAcceptance(bool accepted) {
    return accepted;
  }
}
