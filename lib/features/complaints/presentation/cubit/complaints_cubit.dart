import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../domain/entities/complaints.dart';
import '../../domain/use_case/complaints_use_case.dart';

part 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  final ComplaintsUseCase complaintsUseCase;
  final logger = Logger();

  ComplaintsCubit({required this.complaintsUseCase})
      : super(ComplaintsState.initial());

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> submitComplaint() async {
print("hello");
    emit(state.copyWith(isLoading: true));

    final complaints = Complaints(
      title: subjectController.text,
      description: detailsController.text,
    );

    final result = await complaintsUseCase.callPostComplaints(complaints);

    result.fold(
      (failure) {
        logger.e('Complaint submission failed: ${failure.toString()}');
        emit(state.copyWith(
          isLoading: false,
          error: failure.toString(),
        ));
      },
      (success) {
        logger.i('Complaint submitted successfully');
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          successMessage: success['message'] ?? 'تم إرسال الشكوى بنجاح',
        ));
        _clearForm();
      },
    );
  }

  void _clearForm() {
    subjectController.clear();
    detailsController.clear();
  }

  void updateFields() {
    final isNotEmpty =
        subjectController.text.isNotEmpty && detailsController.text.isNotEmpty;
    emit(state.copyWith(isNotEmpty: isNotEmpty));
  }
  //
  // void initControllers() {
  //   subjectController.addListener(updateFields);
  //   detailsController.addListener(updateFields);
  // }

  @override
  Future<void> close() {
    subjectController.dispose();
    detailsController.dispose();
    return super.close();
  }
}
