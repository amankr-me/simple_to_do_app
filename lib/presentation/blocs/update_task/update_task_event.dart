part of 'update_task_bloc.dart';

abstract class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();

  @override
  List<Object> get props => [];
}


class UpdateTodoEvent extends UpdateTaskEvent {
  final Todo todo;
  const UpdateTodoEvent(this.todo);

  @override
  List<Object> get props => [todo];
}
