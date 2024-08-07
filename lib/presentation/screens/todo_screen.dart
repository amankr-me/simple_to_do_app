import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo.dart';
import '../blocs/add_task/add_task_bloc.dart';
import '../blocs/delete_task/delete_task_bloc.dart';
import '../blocs/filter_task/filter_task_bloc.dart';
import '../blocs/update_task/update_task_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TodoFilter dropdownValue = TodoFilter.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<FilterTaskBloc, FilterTaskState>(
            builder: (blocContext, state) {
              return DropdownButton<TodoFilter>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (TodoFilter? value) {
                  // This is called when the user selects an item.
                  blocContext
                      .read<FilterTaskBloc>()
                      .add(LoadFilterTodos(value!));

                  setState(() {
                    dropdownValue = value;
                  });
                },
                items: [
                  TodoFilter.all,
                  TodoFilter.completed,
                  TodoFilter.pending
                ].map<DropdownMenuItem<TodoFilter>>((TodoFilter value) {
                  return DropdownMenuItem<TodoFilter>(
                    value: value,
                    child: Text(value.name.toUpperCase()),
                  );
                }).toList(),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<FilterTaskBloc, FilterTaskState>(
              builder: (filterBlocContext, state) {
                if (state is FilterTaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FilterTaskLoaded) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
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
                                          .add(UpdateTodoEvent(updatedTodo));
                                      filterBlocContext
                                          .read<FilterTaskBloc>()
                                          .add(LoadFilterTodos(dropdownValue));

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
                                        .add(LoadFilterTodos(dropdownValue));
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is FilterTaskError) {
                  return Center(child: Text(state.message));
                } else if (state is FilterTaskEmpty) {
                  return const Center(child: Text('No todos available'));
                }
                else {
                  return const Center(child: Text('No todos available'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext blocContext) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: blocContext,
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
            BlocListener<AddTaskBloc, AddTaskState>(
              listener: (context, state) {
              },
              child: TextButton(
                child: const Text('Add'),
                onPressed: () {
                  final title = controller.text;
                  if (title.isNotEmpty) {
                    final todo = Todo(
                      id: DateTime.now().toString(),
                      title: title,
                      completed: false,
                    );
                    context
                        .read<AddTaskBloc>()
                        .add(AddTodoEvent(todo));
                    blocContext
                        .read<FilterTaskBloc>()
                        .add(LoadFilterTodos(dropdownValue));
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
