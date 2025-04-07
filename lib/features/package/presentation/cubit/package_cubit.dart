import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/animation.dart';
import 'package:techpeak/features/package/domain/entities/package.dart';
import 'package:techpeak/features/package/domain/usecase/package_use_case.dart';

part 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  final PackageUseCase packageUseCase;
  List<Package> packages = [];

  PackageCubit({required this.packageUseCase}) : super(PackageState.initial()) {
    getPackages();
  }

  Future<void> getPackages() async {
    final result = await packageUseCase.getPackages();
    result.fold(
      (failure) {
        // Handle failure
        emit(state.copyWith(error: failure.toString()));
      },
      (packagesList) {
        packages = packagesList;
        if (packagesList.isNotEmpty) {
          final progress = double.parse(packagesList[0].usagePercentage) / 100;
          emit(state.copyWith(
            packages: packagesList,
            progress: progress,
            currentPackage: packagesList[0],
          ));
        }
      },
    );
  }

  void startProgressAnimation(double targetPercentage) {
    const int steps = 60;
    const duration = Duration(milliseconds: 1500);
    final stepDuration = duration.inMilliseconds ~/ steps;

    emit(state.copyWith(progress: 0.0));

    const curve = Curves.easeOutCubic;

    for (int i = 1; i <= steps; i++) {
      Future.delayed(Duration(milliseconds: i * stepDuration), () {
        final t = curve.transform(i / steps);
        final currentProgress = targetPercentage * t;
        emit(state.copyWith(
          progress: currentProgress,
          currentPage: state.currentPage,
        ));
      });
    }
  }

  void updatePage(int page) {
    if (page < packages.length) {
      final package = packages[page];
      final progress = double.parse(package.usagePercentage) / 100;

      emit(state.copyWith(
        currentPage: page,
        isAnimating: true,
        currentPackage: package,
      ));

      startProgressAnimation(progress);
    }
  }

  void onPageScrolled(double position) {
    if (!state.isAnimating) {
      emit(state.copyWith(pageOffset: position));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
