import 'package:simple_to_do_app/presentation/blocs/filter_task/filter_task_bloc.dart';

import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final List<Todo> _todos = [];

  @override
  Future<void> addTodo(Todo todo) async {
    _todos.add(todo);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  @override
  Future<void> delete(String id) async {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      _todos.removeAt(index);
    } else {
      throw Exception('Todo not found');
    }
  }

  // @override
  // Future<List<Todo>> filterTodos(TodoFilter todoFilter) async {
  //   final filteredTodo;
  //
  //         if(todoFilter==TodoFilter.pending){
  //           filteredTodo=List<Todo>.from(_todos)..removeWhere((element)=>element.completed==true);
  //
  //     }
  //     else if(todoFilter==TodoFilter.completed){
  //           filteredTodo=List<Todo>.from(_todos)..removeWhere((element)=>element.completed==false);
  //
  //     }else if(todoFilter==TodoFilter.all){
  //           filteredTodo=List<Todo>.from(_todos);
  //
  //     }
  //     else{
  //           filteredTodo=List<Todo>.from(_todos);
  //     }//
  //   return filteredTodo;
  // }

  @override
  Future<List<Todo>> getFilterTodos(TodoFilter todoFilter) async {
    List<Todo> filteredTodo;

    // if(todoFilter==TodoFilter.pending){
    //   filteredTodo=List<Todo>.from(_todos)..removeWhere((element)=>element.completed==true);
    //
    // }
    // else if(todoFilter==TodoFilter.completed){
    //   filteredTodo=List<Todo>.from(_todos)..removeWhere((element)=>element.completed==false);
    //
    // }else if(todoFilter==TodoFilter.all){
    //   filteredTodo=List<Todo>.from(_todos);
    //
    // }
    // else{
    //   filteredTodo=List<Todo>.from(_todos);
    // }//

    switch (todoFilter) {
      case TodoFilter.completed:
        filteredTodo = List<Todo>.from(_todos)
          ..removeWhere((element) => element.completed == false);
        break;
      case TodoFilter.pending:
        filteredTodo = List<Todo>.from(_todos)
          ..removeWhere((element) => element.completed == true);
        break;
      case TodoFilter.all:
        filteredTodo=List<Todo>.from(_todos);
        break;

      default:
        filteredTodo = List<Todo>.from(_todos);
        break;
    }
    return filteredTodo;
  }
}
