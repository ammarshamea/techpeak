import 'package:dartz/dartz.dart';
import 'package:techpeak/features/complaints/domain/repositories/complaints_repositories.dart';

import '../../../../core/constante/failure.dart';
import '../entities/complaints.dart';

class ComplaintsUseCase {
  final ComplaintsRepositories complaintsRepositories;

  ComplaintsUseCase({required this.complaintsRepositories});
  Future<Either<Failure, Map<String, dynamic>>> callPostComplaints(Complaints complaints)async{
    return await complaintsRepositories.postComplaints(complaints);
  }
}