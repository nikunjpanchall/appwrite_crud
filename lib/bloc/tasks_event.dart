part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {}

class GetTaskEvent extends TasksEvent {}

class CreateTaskEvent extends TasksEvent {
  final String title;
  final String subtitle;
  CreateTaskEvent(this.title, this.subtitle);
}

class UpdateTaskEvent extends TasksEvent {
  final String title;
  final String subtitle;
  final String id;
  UpdateTaskEvent(this.title, this.subtitle, this.id);
}

class DeleteTaskEvent extends TasksEvent {
  final String id;
  DeleteTaskEvent(this.id);
}
