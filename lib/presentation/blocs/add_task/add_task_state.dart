part of 'add_task_bloc.dart';



abstract class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];


  AddTaskState? fromJson(Map<String, dynamic> json) {
    try {
      final todo = Todo.fromJson(json['todo'] as Map<String, dynamic>);
      return AddTaskLoaded(todo);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AddTaskState state) {
    if (state is AddTaskLoaded) {
      return {
        'todo': state.todo.toJson(),
      };
    }
    return null;
  }
}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskLoaded extends AddTaskState {
  final Todo todo;
  AddTaskLoaded(this.todo);

}

class AddTaskError extends AddTaskState {
  final String message;

  const AddTaskError(this.message);

  @override
  List<Object> get props => [message];
}


