// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

TaskModel userModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String userModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  int id;
  String name;
  DateTime deadlineDate;
  String priority;
  String project;
  String business;
  int timeLevel;
  String userAssignedBy;
  String userAssignedTo;
  String status;
  int userAssignedById;
  int userAssignedToId;

  TaskModel({
    this.id,
    this.name,
    this.deadlineDate,
    this.priority,
    this.project,
    this.business,
    this.timeLevel,
    this.userAssignedBy,
    this.userAssignedTo,
    this.status,
    this.userAssignedById,
    this.userAssignedToId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        name: json["name"],
        deadlineDate: DateTime.parse(json["deadlineDate"]),
        priority: json["priority"],
        project: json["project"],
        business: json["business"],
        timeLevel: json["timeLevel"],
        userAssignedBy: json["userAssignedBy"],
        userAssignedTo: json["userAssignedTo"],
        status: json["status"],
        userAssignedById: json["userAssignedById"],
        userAssignedToId: json["userAssignedToId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deadlineDate": deadlineDate.toIso8601String(),
        "priority": priority,
        "project": project,
        "business": business,
        "timeLevel": timeLevel,
        "userAssignedBy": userAssignedBy,
        "userAssignedTo": userAssignedTo,
        "status": status,
        "userAssignedById": userAssignedById,
        "userAssignedToId": userAssignedToId,
      };
}
