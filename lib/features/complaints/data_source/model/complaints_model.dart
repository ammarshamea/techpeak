import 'package:techpeak/features/complaints/domain/entities/complaints.dart';

class ComplaintsModel extends Complaints {
  ComplaintsModel({required super.title, required super.description});

  factory ComplaintsModel.fromJson(Map<String, dynamic> json){
    return ComplaintsModel(title: json["title"], description: json["description"]);
  }
  Map<String, dynamic> toJson(){
    return {
      "title":title,
      "description":description,
    };}
}