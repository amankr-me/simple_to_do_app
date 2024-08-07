import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/domain/entities/todo.dart';
import 'package:simple_to_do_app/domain/usecases/add_todo.dart';
import 'package:simple_to_do_app/presentation/blocs/add_task/add_task_bloc.dart';

class MockAddTodo extends Mock implements AddTodo {}


void main() {
  late AddTaskBloc addTaskBloc;
  late MockAddTodo mockAddTodo;

  setUpAll(() {
    registerFallbackValue(const Todo(
      id: '1',
      title: 'Test Todo',
      completed: false,
    ));
  });


  setUp(() {
    mockAddTodo = MockAddTodo();
    addTaskBloc = AddTaskBloc(mockAddTodo);
  });

  group('AddTaskBloc', () {
    const todo = Todo(
      id: '1',
      title: 'Test Todo',
      completed: false,
    );

    blocTest<AddTaskBloc, AddTaskState>(
      'emits [AddTaskLoaded] when AddTodoEvent is added and todo is added successfully',
      build: () {
        when(() => mockAddTodo.call(any())).thenAnswer((_) async => {});
        return addTaskBloc;
      },
      act: (bloc) => bloc.add(AddTodoEvent(todo)),
      expect: () => [
        AddTaskLoaded(),
      ],
      verify: (_) {
        verify(() => mockAddTodo.call(todo)).called(1);
      },
    );

    blocTest<AddTaskBloc, AddTaskState>(
      'emits [AddTaskError] when AddTodoEvent is added and adding todo fails',
      build: () {
        when(() => mockAddTodo.call(any())).thenThrow(Exception('Failed to add todo'));
        return addTaskBloc;
      },
      act: (bloc) => bloc.add(AddTodoEvent(todo)),
      expect: () => [
        const AddTaskError('Failed to add todo'),
      ],
    );
  });
}
