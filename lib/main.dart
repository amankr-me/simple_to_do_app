import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
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
import 'domain/usecases/get_todo.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory(),
  );

  final todoRepository = TodoRepositoryImpl();
  final getFilteredTodos = GetFilteredTodos(todoRepository);
  final getTodos = GetTodos(todoRepository);
  final addTodo = AddTodo(todoRepository);
  final updateTodo = UpdateTodo(todoRepository);
  final deleteTodo = DeleteTodo(todoRepository);

  runApp(MyApp(addTodo, updateTodo, deleteTodo,getFilteredTodos,getTodos));
}

class MyApp extends StatelessWidget {
  final GetFilteredTodos getFilteredTodos;
  final GetTodos getTodos;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  const MyApp( this.addTodo, this.updateTodo, this.deleteTodo,this.getFilteredTodos,this.getTodos, {super.key});

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
          create: (BuildContext context) => FilterTaskBloc(getFilteredTodos,getTodos)..add(LoadFilterTodos(TodoFilter.all)),
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
