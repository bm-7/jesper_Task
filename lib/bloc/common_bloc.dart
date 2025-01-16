import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jesper_task/model/task_model.dart';
import 'package:meta/meta.dart';
import '../repository/repository.dart';

part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  final TaskRepository taskRepository;
  CommonBloc({required this.taskRepository}) : super(CommonInitial()) {
    on<TaskDataIntialFetch>(taskDataIntialFetch);
  }

  FutureOr<void> taskDataIntialFetch(
      TaskDataIntialFetch event, Emitter<CommonState> emit) async {
    try {
      emit(CommonLoading());


      List<TaskModel> taskData = await taskRepository.getTasks();

      emit(CommonLoaded(taskData));

    } catch (e) {
      emit(CommonError(e.toString()));
    }
  }
}
