part of 'delete_task_bloc.dart';

abstract class DeleteTaskEvent extends Equatable {
  const DeleteTaskEvent();

  @override
  List<Object> get props => [];
}



class DeleteTodoEvent extends DeleteTaskEvent {
  final Todo todo;
  const DeleteTodoEvent(this.todo, );
}



