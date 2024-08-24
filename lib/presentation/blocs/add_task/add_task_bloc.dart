import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/add_todo.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AddTodo addTodo;

  AddTaskBloc(this.addTodo) : super(AddTaskInitial()) {
    on<AddTodoEvent>(_onAddTodo);
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<AddTaskState> emit) async {
    try {
      await addTodo(event.todo);
      emit(AddTaskLoaded(event.todo));
    } catch (_) {
      emit(const AddTaskError("Failed to add todo"));
    }
  }

  // @override
  // AddTaskState? fromJson(Map<String, dynamic> json) {
  //   print("fromcalled");
  //   try {
  //     final todo = Todo.fromJson(json['todo'] as Map<String, dynamic>);
  //     return AddTaskLoaded(todo);
  //   } catch (_) {
  //     return null;
  //   }
  // }
  //
  // @override
  // Map<String, dynamic>? toJson(AddTaskState state) {
  //   print("tojsonCalled");
  //   if (state is AddTaskLoaded) {
  //     return {
  //       'todo': state.todo.toJson(),
  //     };
  //   }
  //   return null;
  // }
}
