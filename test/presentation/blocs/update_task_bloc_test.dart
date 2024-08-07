import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/domain/entities/todo.dart';
import 'package:simple_to_do_app/domain/usecases/update_todo.dart';
import 'package:simple_to_do_app/presentation/blocs/update_task/update_task_bloc.dart';

class MockUpdateTodo extends Mock implements UpdateTodo {}

void main() {
  late UpdateTaskBloc updateTaskBloc;
  late MockUpdateTodo mockUpdateTodo;

  setUpAll(() {
    registerFallbackValue(const Todo(
      id: '1',
      title: 'Test Todo',
      completed: false,
    ));
  });

  setUp(() {
    mockUpdateTodo = MockUpdateTodo();
    updateTaskBloc = UpdateTaskBloc(mockUpdateTodo);
  });

  group('UpdateTaskBloc', () {
    const todo = Todo(
      id: '1',
      title: 'Test Todo',
      completed: false,
    );

    blocTest<UpdateTaskBloc, UpdateTaskState>(
      'emits [UpdateTaskLoaded] when UpdateTodoEvent is added and todo is updated successfully',
      build: () {
        when(() => mockUpdateTodo.call(any())).thenAnswer((_) async => {});
        return updateTaskBloc;
      },
      act: (bloc) => bloc.add(const UpdateTodoEvent(todo)),
      expect: () => [
        UpdateTaskLoaded(),
      ],
      verify: (_) {
        verify(() => mockUpdateTodo.call(todo)).called(1);
      },
    );

    blocTest<UpdateTaskBloc, UpdateTaskState>(
      'emits [UpdateTaskError] when UpdateTodoEvent is added and updating todo fails',
      build: () {
        when(() => mockUpdateTodo.call(any())).thenThrow(Exception('Failed to update todo'));
        return updateTaskBloc;
      },
      act: (bloc) => bloc.add(const UpdateTodoEvent(todo)),
      expect: () => [
        const UpdateTaskError('Failed to update todo'),
      ],
    );
  });
}
