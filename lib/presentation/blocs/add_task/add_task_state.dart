part of 'add_task_bloc.dart';



abstract class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskLoaded extends AddTaskState {}

class AddTaskError extends AddTaskState {
  final String message;

  const AddTaskError(this.message);

  @override
  List<Object> get props => [message];
}


