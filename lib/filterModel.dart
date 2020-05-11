// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

FilterModel filterModelFromJson(String str) =>
    FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  String filter;
  int pageNumber;
  String orderBy;
  String orderDirection;
  int pageSize;
  String userIdAssignedTo;
  String userIdAssignedBy;
  String projectId;
  String businessId;
  String searchQuery;

  FilterModel({
    this.filter = "Uncompleted",
    this.pageNumber = 1,
    this.orderBy = "deadlineDate",
    this.orderDirection = "ASC",
    this.pageSize = 10,
    this.userIdAssignedTo = "",
    this.userIdAssignedBy = "",
    this.projectId = "",
    this.businessId = "",
    this.searchQuery = "",
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        filter: json["filter"] ?? "Uncompleted",
        pageNumber: json["pageNumber"] ?? 1,
        orderBy: json["orderBy"] ?? "deadlineDate",
        orderDirection: json["orderDirection"] ?? "ASC",
        pageSize: json["pageSize"] ?? 10,
        userIdAssignedTo: json["userIdAssignedTo"] ?? "",
        userIdAssignedBy: json["userIdAssignedBy"] ?? "",
        projectId: json["projectId"] ?? "",
        businessId: json["businessId"] ?? "",
        searchQuery: json["searchQuery"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "filter": filter,
        "pageNumber": pageNumber,
        "orderBy": orderBy,
        "orderDirection": orderDirection,
        "pageSize": pageSize,
        "userIdAssignedTo": userIdAssignedTo,
        "userIdAssignedBy": userIdAssignedBy,
        "projectId": projectId,
        "businessId": businessId,
        "searchQuery": searchQuery,
      };

  Map<String, dynamic> get getShortParams => {
        "filter": filter,
        "pageNumber": pageNumber,
        "orderBy": orderBy,
        "orderDirection": orderDirection,
        "pageSize": pageSize,
      };
}
