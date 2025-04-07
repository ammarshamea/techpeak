import 'package:equatable/equatable.dart';

class Complaints extends Equatable{
  final String title;
  final String description;

  Complaints({required this.title, required this.description});

  @override
  // TODO: implement props
  List<Object?> get props => [title, description];
}