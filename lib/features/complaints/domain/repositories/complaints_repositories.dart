import 'package:dartz/dartz.dart';
import 'package:techpeak/core/constante/failure.dart';

import '../entities/complaints.dart';

abstract class ComplaintsRepositories {
  Future<Either<Failure, Map<String, dynamic>>> postComplaints(
      Complaints complaints);
}
