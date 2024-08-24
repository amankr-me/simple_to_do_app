
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/add_todo.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AddTodo addTodo;


  AddTaskBloc(this.addTodo, )
      : super(AddTaskInitial()) {
    on<AddTodoEvent>(_onAddTodo);
  }


  Future<void> _onAddTodo(AddTodoEvent event, Emitter<AddTaskState> emit) async {
    try {
      await addTodo(event.todo);
      emit(AddTaskLoaded());

    } catch (_) {
      emit(const AddTaskError("Failed to add todo"));
    }
  }
}
