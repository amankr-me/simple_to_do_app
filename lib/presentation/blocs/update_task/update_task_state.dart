part of 'update_task_bloc.dart';

abstract class UpdateTaskState extends Equatable {
  const UpdateTaskState();

  @override
  List<Object> get props => [];
}

class UpdateTaskInitial extends UpdateTaskState {}

class UpdateTaskLoading extends UpdateTaskState {}

class UpdateTaskLoaded extends UpdateTaskState {}

class UpdateTaskError extends UpdateTaskState {
  final String message;

  const UpdateTaskError(this.message);

  @override
  List<Object> get props => [message];
}