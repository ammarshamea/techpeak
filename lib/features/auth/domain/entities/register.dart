import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String username;
  final String macAddress;
  final bool terms;

  const Register({
    required this.username,
    required this.macAddress,
    required this.terms,
  });

  @override
  List<Object?> get props => [username, macAddress, terms];
}
