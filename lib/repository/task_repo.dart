import 'package:appwrite/appwrite.dart';
import 'package:demo_appwrite/app_constants.dart';
import 'package:demo_appwrite/models/task_model.dart';

class TaskRepository {
  Future<void> createTask(String title, String subtitle) async {
    Client client = Client();
    Databases databases = Databases(client);
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId)
        .setSelfSigned(status: true);

    final result = await databases.createDocument(
      databaseId: '646b661a32377ed63286',
      collectionId: '646b6623a868a0713748',
      documentId: ID.unique(),
      data: {'title': title, 'subtitle': subtitle},
    );

    // result.then((response) {
    //   if (kDebugMode) {
    //     print(response);
    //   }
    // }).catchError((error) {
    //   print(error.response);
    // });
  }

  Future<List<TaskModel>?> getTask() async {
    Client client = Client();
    Databases databases = Databases(client);
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId)
        .setSelfSigned(status: true);

    List<TaskModel>? taskList = [];
    final response = await databases.listDocuments(
        collectionId: AppConstants.collectionId, databaseId: AppConstants.databaseId);

    taskList = response.documents.map((e) {
      return TaskModel.fromJson(e.data);
    }).toList();

    return taskList;
  }

  Future<void> updateTask(String title, String subtitle, String id) async {
    Client client = Client();
    Databases databases = Databases(client);
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId)
        .setSelfSigned(status: true);

    databases.updateDocument(
        databaseId: '646b661a32377ed63286',
        collectionId: '646b6623a868a0713748',
        documentId: id,
        data: {'title': title, 'subtitle': subtitle});
  }

  Future<void> deleteTask(String id) async {
    Client client = Client();
    Databases databases = Databases(client);
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId)
        .setSelfSigned(status: true);

    await databases.deleteDocument(
        databaseId: '646b661a32377ed63286', collectionId: '646b6623a868a0713748', documentId: id);
  }
}
