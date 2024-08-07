
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/update_todo.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTodoEvent, UpdateTaskState> {
  final UpdateTodo updateTodo;


  UpdateTaskBloc( this.updateTodo)
      : super(UpdateTaskInitial()) {
    on<UpdateTodoEvent>(_onUpdateTodo);
  }

  Future<void> _onUpdateTodo(UpdateTodoEvent event, Emitter<UpdateTaskState> emit) async {
    try {
      await updateTodo(event.todo);
      emit(UpdateTaskLoaded());
    } catch (_) {
      emit(UpdateTaskError("Failed to update todo"));
    }
  }


}
