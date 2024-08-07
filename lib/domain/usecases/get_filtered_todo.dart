
import 'package:simple_to_do_app/presentation/blocs/filter_task/filter_task_bloc.dart';

import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetFilteredTodos {
  final TodoRepository repository;

  GetFilteredTodos(this.repository);

  Future<List<Todo>> call(TodoFilter todoFilter) async {
    return await repository.getFilterTodos(todoFilter);
  }
}
