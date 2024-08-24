import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Future<List<Todo>> call(List<Todo> todos) async {
    return await repository.getTodos(todos);
  }
}