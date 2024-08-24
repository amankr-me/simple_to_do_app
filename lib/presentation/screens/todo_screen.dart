import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_to_do_app/presentation/screens/dropdown_widget.dart';
import '../../domain/entities/todo.dart';
import '../blocs/add_task/add_task_bloc.dart';
import '../blocs/delete_task/delete_task_bloc.dart';
import '../blocs/dropdown/dropdown_bloc.dart';
import '../blocs/dropdown/dropdown_state.dart';
import '../blocs/filter_task/filter_task_bloc.dart';
import '../blocs/update_task/update_task_bloc.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  // TodoFilter dropdownValue = TodoFilter.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: BlocBuilder<DropdownBloc, DropdownState>(
        builder: (dropdownContext, dropDownstate) {
          print("dropDownstate");
          print(dropDownstate);
          return Column(
            children: [
              DropdownWidget(),
              Expanded(
                child: BlocBuilder<FilterTaskBloc, FilterTaskState>(

                  builder: (filterBlocContext, filterState) {
                    print("filterState");
                    print(filterState);
                    if (filterState is FilterTaskLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (filterState is FilterTaskLoaded) {
                      return ListView.builder(
                        itemCount: filterState.todos.length,
                        itemBuilder: (context, index) {
                          final todo = filterState.todos[index];
                          return ListTile(
                            title: Text(todo.title),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BlocBuilder<UpdateTaskBloc, UpdateTaskState>(
                                  builder: (context, state) {
                                    return Checkbox(
                                      value: todo.completed,
                                      onChanged: (bool? newValue) {
                                        if (newValue != null) {
                                          final updatedTodo =
                                          todo.copyWith(completed: newValue);
                                          context
                                              .read<UpdateTaskBloc>()
                                              .add(
                                              UpdateTodoEvent(updatedTodo));
                                          filterBlocContext
                                              .read<FilterTaskBloc>()
                                              .add(LoadFilterTodos(dropDownstate.selectedItem));

                                          // BlocProvider.of<TodoBloc>(context).add(UpdateTodoEvent(updatedTodo,dropdownValue));
                                        }
                                      },
                                    );
                                  },
                                ),
                                BlocBuilder<DeleteTaskBloc, DeleteTaskState>(
                                  builder: (context, state) {
                                    return IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        context
                                            .read<DeleteTaskBloc>()
                                            .add(DeleteTodoEvent(todo));
                                        filterBlocContext
                                            .read<FilterTaskBloc>()
                                            .add( LoadFilterTodos(
                                            dropDownstate.selectedItem));
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (filterState is FilterTaskError) {
                      return Center(child: Text(filterState.message));
                    } else if (filterState is FilterTaskEmpty) {
                      return const Center(child: Text('No todos available'));
                    }
                    else {
                      return const Center(child: Text('No todos available'));
                    }
                  },
                ),
              ),

            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<DropdownBloc, DropdownState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              _showAddTodoDialog(context, state.selectedItem);
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context, TodoFilter selectedFilter) {
    final TextEditingController controller = TextEditingController();


    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a New Todo'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter todo title'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            TextButton(
              child: const Text('Add'),
              onPressed: () {
                final title = controller.text;
                if (title.isNotEmpty) {
                  // final todo = Todo(
                  //   id: DateTime.now().toString(),
                  //   title: title,
                  //   completed: false,
                  // );
                  context
                      .read<AddTaskBloc>()
                      .add(AddTodoEvent(Todo.fromJson(
                      {"id": (DateTime
                          .now()
                          .microsecondsSinceEpoch +
                          Random().nextInt(9999999)).toString(),
                        "title":title,
                        "completed": false,

                      }
                      )));
                  context
                      .read<FilterTaskBloc>()
                      .add(LoadFilterTodos(selectedFilter));
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      },
    );
  }
}
