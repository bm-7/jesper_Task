part of 'common_bloc.dart';

@immutable
sealed class CommonState {}

final class CommonInitial extends CommonState {}

final class CommonLoading extends CommonState {}

final class CommonLoaded extends CommonState {
  final List<TaskModel> loadedData;
  CommonLoaded(this.loadedData);
}

final class CommonError extends CommonState {
  final String message;
  CommonError(this.message);
}
