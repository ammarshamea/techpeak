import 'package:flutter_bloc/flutter_bloc.dart';

class InternetDetailsCubit extends Cubit<double> {
  InternetDetailsCubit() : super(0.0);

  void updateProgress(double progress) {
    emit(progress);
  }
}
