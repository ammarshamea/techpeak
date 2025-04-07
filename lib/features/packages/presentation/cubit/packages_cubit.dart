import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/package_model.dart';

class PackagesCubit extends Cubit<List<PackageModel>> {
  PackagesCubit() : super([]);

  void loadPackages() {
    final packages = [
      PackageModel(
        name: 'باقة شهرية',
        size: '100 جيجابايت',
        price: '50',
        duration: '30 يوم',
        features: [
          'تصفح غير محدود',
          'دعم فني على مدار الساعة',
          'تركيب مجاني',
          'راوتر مجاني',
        ],
        isPopular: true,
      ),
      PackageModel(
        name: 'باقة أسبوعية',
        size: '50 جيجابايت',
        price: '30',
        duration: '7 أيام',
        features: [
          'تصفح غير محدود',
          'دعم فني على مدار الساعة',
          'تركيب مجاني',
        ],
      ),
      // Add more packages as needed
    ];

    // emit(state.copyWith(
    //   packages: packages,
    //   isLoading: false,
    // ));
  }
}
