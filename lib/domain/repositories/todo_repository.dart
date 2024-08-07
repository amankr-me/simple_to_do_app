

import '../../presentation/blocs/filter_task/filter_task_bloc.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getFilterTodos(TodoFilter todoFilter);
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> delete(String id); // Add this method

}
