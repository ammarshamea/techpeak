part of 'complaints_cubit.dart';

class ComplaintsState {
  final bool isNotEmpty;
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final String? successMessage;

  ComplaintsState({
    required this.isNotEmpty,
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.successMessage,
  });

  factory ComplaintsState.initial() {
    return ComplaintsState(
      isNotEmpty: false,
      isLoading: false,
      isSuccess: false,
    );
  }

  ComplaintsState copyWith({
    bool? isNotEmpty,
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? successMessage,
  }) {
    return ComplaintsState(
      isNotEmpty: isNotEmpty ?? this.isNotEmpty,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      successMessage: successMessage,
    );
  }
}
