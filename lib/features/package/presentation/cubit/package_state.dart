part of 'package_cubit.dart';

class PackageState {
  final double progress;
  final int currentPage;
  final double pageOffset;
  final bool isAnimating;
  final List<Package> packages;
  final String? error;
  final Package? currentPackage;

  PackageState({
    required this.progress,
    required this.currentPage,
    required this.pageOffset,
    required this.isAnimating,
    required this.packages,
    this.error,
    this.currentPackage,
  });

  factory PackageState.initial() {
    return PackageState(
      progress: 0.0,
      currentPage: 0,
      pageOffset: 0.0,
      isAnimating: false,
      packages: [],
    );
  }

  PackageState copyWith({
    double? progress,
    int? currentPage,
    double? pageOffset,
    bool? isAnimating,
    List<Package>? packages,
    String? error,
    Package? currentPackage,
  }) {
    return PackageState(
      progress: progress ?? this.progress,
      currentPage: currentPage ?? this.currentPage,
      pageOffset: pageOffset ?? this.pageOffset,
      isAnimating: isAnimating ?? this.isAnimating,
      packages: packages ?? this.packages,
      error: error ?? this.error,
      currentPackage: currentPackage ?? this.currentPackage,
    );
  }
}
