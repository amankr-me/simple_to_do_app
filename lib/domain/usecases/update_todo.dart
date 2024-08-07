import '../repositories/todo_repository.dart';

import '../entities/todo.dart';

class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<void> call(Todo todo) async {
    await repository.updateTodo(todo);
  }
}