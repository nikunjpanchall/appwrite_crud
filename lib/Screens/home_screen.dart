import 'package:demo_appwrite/bloc/tasks_bloc.dart';
import 'package:demo_appwrite/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  List<TaskModel>? taskList = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() {
    BlocProvider.of<TasksBloc>(context).add(GetTaskEvent());
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appwrite Demo"),
        centerTitle: true,
      ),
      body: BlocConsumer<TasksBloc, TasksState>(
        listener: (context, state) {
          if (state is GetTaskState && state.isCompleted) {
            taskList = state.taskModel;
          }
          if (state is CreateTaskState && state.isCompleted) {
            _getData();
          }
          if (state is UpdateTaskState && state.isCompleted) {
            _getData();
          }
          if (state is DeleteTaskState && state.isCompleted) {
            _getData();
          }
        },
        builder: (context, state) {
          return state is GetTaskState && state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: taskList?.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 1,
                            onPressed: (value) {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.vertical(top: Radius.circular(25.0))),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "Add Your Task",
                                            style: TextStyle(
                                              fontSize: 24,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            controller: titleController,
                                            decoration: InputDecoration(
                                              border: const OutlineInputBorder(),
                                              hintText: taskList?[index].title ?? "",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            controller: subtitleController,
                                            decoration: InputDecoration(
                                              border: const OutlineInputBorder(),
                                              hintText: taskList?[index].subtitle ?? "",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              BlocProvider.of<TasksBloc>(context).add(
                                                UpdateTaskEvent(
                                                  titleController.text,
                                                  subtitleController.text,
                                                  taskList?[index].id ?? "",
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(400, 40),
                                            ),
                                            child: const Text("Add Task"),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: Icons.update,
                            label: 'Update',
                          ),
                          SlidableAction(
                            onPressed: (value) {
                              BlocProvider.of<TasksBloc>(context)
                                  .add(DeleteTaskEvent(taskList?[index].id ?? ""));
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Save',
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          taskList?[index].title ?? "hello",
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(taskList?[index].subtitle ?? ""),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Add Your Task",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Your title',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: subtitleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Your Subtitle',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<TasksBloc>(context)
                              .add(CreateTaskEvent(titleController.text, subtitleController.text));
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 40),
                        ),
                        child: const Text("Add Task"),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
