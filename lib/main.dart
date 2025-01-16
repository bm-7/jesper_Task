import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jesper_task/provider/api_provider.dart';
import 'package:jesper_task/repository/repository.dart';
import 'package:jesper_task/presentation/home_page.dart';

import 'bloc/common_bloc.dart';

void main() {
  final apiProvider = ApiProvider();
  final taskRepository = TaskRepository(apiProvider: apiProvider);

  runApp(MyApp(taskRepository: taskRepository));
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;

  const MyApp({super.key, required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommonBloc(taskRepository: taskRepository)
        ..add(TaskDataIntialFetch()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
