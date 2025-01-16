import '../model/task_model.dart';
import '../provider/api_provider.dart';

class TaskRepository {
  final ApiProvider apiProvider;

  TaskRepository({required this.apiProvider});

  Future<List<TaskModel>> getTasks() async {
      return await apiProvider.getTaskDataList();
  }
}
