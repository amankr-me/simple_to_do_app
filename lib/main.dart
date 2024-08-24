import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_to_do_app/domain/usecases/delete_todo.dart';
import 'package:simple_to_do_app/domain/usecases/get_filtered_todo.dart';
import 'package:simple_to_do_app/domain/usecases/update_todo.dart';
import 'package:simple_to_do_app/presentation/blocs/add_task/add_task_bloc.dart';
import 'package:simple_to_do_app/presentation/blocs/delete_task/delete_task_bloc.dart';
import 'package:simple_to_do_app/presentation/blocs/dropdown/dropdown_bloc.dart';
import 'package:simple_to_do_app/presentation/blocs/filter_task/filter_task_bloc.dart';
import 'package:simple_to_do_app/presentation/blocs/update_task/update_task_bloc.dart';
import 'package:simple_to_do_app/presentation/screens/todo_screen.dart';
import '../data/repositories/todo_repository.dart';
import '../domain/usecases/add_todo.dart';

void main() {
  final todoRepository = TodoRepositoryImpl();
  final getFilteredTodos = GetFilteredTodos(todoRepository);
  final addTodo = AddTodo(todoRepository);
  final updateTodo = UpdateTodo(todoRepository);
  final deleteTodo = DeleteTodo(todoRepository);

  runApp(MyApp(addTodo, updateTodo, deleteTodo,getFilteredTodos));
}

class MyApp extends StatelessWidget {
  final GetFilteredTodos getFilteredTodos;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  const MyApp( this.addTodo, this.updateTodo, this.deleteTodo,this.getFilteredTodos, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddTaskBloc>(
          create: (BuildContext context) => AddTaskBloc(addTodo),
        ),
        BlocProvider<DeleteTaskBloc>(
          create: (BuildContext context) => DeleteTaskBloc(deleteTodo),
        ),
        BlocProvider<UpdateTaskBloc>(
          create: (BuildContext context) => UpdateTaskBloc(updateTodo),
        ),
        BlocProvider<FilterTaskBloc>(
          create: (BuildContext context) => FilterTaskBloc(getFilteredTodos)..add(LoadFilterTodos(TodoFilter.all)),
        ),
        BlocProvider(
          create: (dropdownContext) => DropdownBloc([TodoFilter.all, TodoFilter.pending, TodoFilter.completed]),
        ),


      ],
      child: const MaterialApp(
        home: TodoScreen(),
      ),
    );
  }
}
