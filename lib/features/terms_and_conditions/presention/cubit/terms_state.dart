import 'package:equatable/equatable.dart';
import '../../domain/entities/term_and_conditions.dart';

abstract class TermsState extends Equatable {
  const TermsState();

  @override
  List<Object?> get props => [];
}

class TermsInitial extends TermsState {}

class TermsLoading extends TermsState {}

class TermsLoaded extends TermsState {
  final List<TermAndConditions> terms;

  const TermsLoaded({
    required this.terms,
  });

  @override
  List<Object?> get props => [terms, ];
}

class TermsError extends TermsState {
  final String message;

  const TermsError(this.message);

  @override
  List<Object?> get props => [message];
}

class TermsAcceptanceUpdated extends TermsState {
  final bool isAccepted;

  const TermsAcceptanceUpdated(this.isAccepted);

  @override
  List<Object?> get props => [isAccepted];
} 