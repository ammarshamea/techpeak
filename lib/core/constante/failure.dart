

import 'package:equatable/equatable.dart';

const String SERVER_FAILURE_MESSAGE = 'Please try again later .';
const String EMPTY_CACHE_FAILURE_MESSAGE = 'No Data';
const String OFFLINE_FAILURE_MESSAGE = 'Please Check your Internet Connection';
const ADD_SUCCESS_MESSAGE = "Account Exist ";
const DELETE_SUCCESS_MESSAGE = "Account Deleted ";
const UPDATE_SUCCESS_MESSAGE = "Account Updated ";

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  final String message;

  OfflineFailure({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class EmptyFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
