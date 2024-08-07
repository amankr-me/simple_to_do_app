import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/delete_todo.dart';


part 'delete_task_event.dart';
part 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  final DeleteTodo deleteTodo;


  DeleteTaskBloc( this.deleteTodo)
      : super(DeleteTaskInitial()) {
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onDeleteTodo(DeleteTodoEvent event, Emitter<DeleteTaskState> emit) async {
    try {
      await deleteTodo(event.todo.id);
      emit(DeleteTaskLoaded());
    } catch (_) {
      emit(const DeleteTaskError("Failed to delete todo"));
    }
  }
}
