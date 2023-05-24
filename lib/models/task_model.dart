import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toMap());

class TaskModel {
  String title;
  String subtitle;
  String id;
  TaskModel({required this.title, required this.subtitle, required this.id});

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      TaskModel(title: json["title"], subtitle: json["subtitle"], id: json["\$id"]);

  Map<String, dynamic> toMap() => {"title ": title, "subtitle": subtitle, "\$id": id};
}
