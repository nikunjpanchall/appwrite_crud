import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:demo_appwrite/models/task_model.dart';
import 'package:demo_appwrite/repository/task_repo.dart';
import 'package:meta/meta.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial()) {
    TaskRepository taskRepository = TaskRepository();
    on<GetTaskEvent>((event, emit) async {
      try {
        emit(GetTaskState(isLoading: true));
        final response = await taskRepository.getTask();
        emit(GetTaskState(isLoading: false, isCompleted: true, taskModel: response));
      } on AppwriteException catch (e) {
        print('exception -${e.toString()}');
        emit(GetTaskState(hasError: true));
      }
    });
    on<CreateTaskEvent>((event, emit) async {
      try {
        emit(CreateTaskState(isLoading: true));
        await taskRepository.createTask(event.title, event.subtitle);
        emit(CreateTaskState(isLoading: false, isCompleted: true));
      } on AppwriteException catch (e) {
        emit(CreateTaskState(hasError: true));
      }
    });
    on<UpdateTaskEvent>((event, emit) async {
      try {
        emit(UpdateTaskState(isLoading: true));
        await taskRepository.updateTask(event.title, event.subtitle, event.id);
        emit(UpdateTaskState(isLoading: false, isCompleted: true));
      } on AppwriteException catch (e) {
        emit(UpdateTaskState(hasError: true));
      }
    });
    on<DeleteTaskEvent>((event, emit) async {
      try {
        emit(DeleteTaskState(isLoading: true));
        await taskRepository.deleteTask(event.id);
        emit(DeleteTaskState(isLoading: false, isCompleted: true));
      } on AppwriteException catch (e) {
        emit(DeleteTaskState(hasError: true));
      }
    });
  }
}
