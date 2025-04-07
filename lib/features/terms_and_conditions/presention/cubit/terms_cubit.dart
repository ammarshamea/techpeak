import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/terms_use_case.dart';
import 'terms_state.dart';

class TermsCubit extends Cubit<TermsState> {
  final TermsUseCase _termsUseCase;
bool isAccepted=false;
  TermsCubit({
    required TermsUseCase termsUseCase,
  })  : _termsUseCase = termsUseCase,
        super(TermsInitial());

  Future<void> loadTerms() async {
    emit(TermsLoading());

    try {
      final result = await _termsUseCase.callTerms();

      result.fold(
        (failure) => emit(TermsError(failure['message'] ?? 'Failed to load terms')),
        (terms) => emit(
          TermsLoaded(
            terms: terms,
          ),
        ),
      );
    } catch (e) {
      emit(TermsError(e.toString()));
    }
  }

  void isTermsAccepted(bool accepted) {
    final valueOfCheck = _termsUseCase.checkTermsAcceptance(accepted);
    emit(TermsAcceptanceUpdated(valueOfCheck));
    isAccepted = valueOfCheck;
  }
} 