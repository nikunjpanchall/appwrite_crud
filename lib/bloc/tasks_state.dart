part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class GetTaskState extends TasksState {
  final bool isLoading;
  final bool isCompleted;
  final bool hasError;
  final List<TaskModel>? taskModel;
  GetTaskState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
    this.taskModel,
  });
}

class CreateTaskState extends TasksState {
  final bool isLoading;
  final bool isCompleted;
  final bool hasError;
  CreateTaskState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
  });
}

class UpdateTaskState extends TasksState {
  final bool isLoading;
  final bool isCompleted;
  final bool hasError;
  UpdateTaskState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
  });
}

class DeleteTaskState extends TasksState {
  final bool isLoading;
  final bool isCompleted;
  final bool hasError;
  DeleteTaskState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
  });
}
