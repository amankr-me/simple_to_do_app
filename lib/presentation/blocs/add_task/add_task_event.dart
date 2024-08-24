part of 'add_task_bloc.dart';


abstract class AddTaskEvent extends Equatable {
  const AddTaskEvent();
  @override
  List<Object> get props => [];
}

class AddTodoEvent extends AddTaskEvent{
  final Todo todo;
  const AddTodoEvent(this.todo);
}