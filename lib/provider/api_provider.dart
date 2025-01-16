import 'dart:convert';
import 'package:http_auth/http_auth.dart';
import '../model/task_model.dart';

class ApiProvider {

  final String baseUrl =
      "https://dev-zautae.zautae.com/api/branchList?organization_id=1";

  final String username = "zautae";
  final String password = "zautae@123#";

  Future<List<TaskModel>> getTaskDataList() async {
    final client = BasicAuthClient(username, password);
      final response = await client.get(
        Uri.parse(baseUrl),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<TaskModel> data = List<TaskModel>.from(
          jsonResponse['data'].map((item) => TaskModel.fromJson(item)),
        );
        print(data);
        print(data.length);
        return data;
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }

  }
}
