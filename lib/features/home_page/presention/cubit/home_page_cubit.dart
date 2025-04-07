import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<int> {
  HomePageCubit() : super(0);

  void changePage(int index, BuildContext context) {
    emit(index);
  }
}
