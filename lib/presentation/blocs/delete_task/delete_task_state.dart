part of 'delete_task_bloc.dart';

abstract class DeleteTaskState extends Equatable {
  const DeleteTaskState();

  @override
  List<Object> get props => [];
}

class DeleteTaskInitial extends DeleteTaskState {}

class DeleteTaskLoading extends DeleteTaskState {}

class DeleteTaskLoaded extends DeleteTaskState {}

class DeleteTaskError extends DeleteTaskState {
  final String message;

  const DeleteTaskError(this.message);

  @override
  List<Object> get props => [message];
}
