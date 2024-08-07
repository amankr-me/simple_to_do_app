import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/domain/entities/todo.dart';
import 'package:simple_to_do_app/domain/usecases/delete_todo.dart';
import 'package:simple_to_do_app/presentation/blocs/delete_task/delete_task_bloc.dart';

class MockDeleteTodo extends Mock implements DeleteTodo {}

void main() {
  late DeleteTaskBloc deleteTaskBloc;
  late MockDeleteTodo mockDeleteTodo;

  setUpAll(() {
    registerFallbackValue(const Todo(
      id: '1',
      title: 'Test Todo',
      completed: false,
    ));
  });

  setUp(() {
    mockDeleteTodo = MockDeleteTodo();
    deleteTaskBloc = DeleteTaskBloc(mockDeleteTodo);
  });

  group('DeleteTaskBloc', () {
    const todo = Todo(
      id: '1',
      title: 'Test Todo',
      completed: false,
    );

    blocTest<DeleteTaskBloc, DeleteTaskState>(
      'emits [DeleteTaskLoaded] when DeleteTodoEvent is added and todo is deleted successfully',
      build: () {
        when(() => mockDeleteTodo.call(any())).thenAnswer((_) async => {});
        return deleteTaskBloc;
      },
      act: (bloc) => bloc.add(const DeleteTodoEvent(todo)),
      expect: () => [
        DeleteTaskLoaded(),
      ],
      verify: (_) {
        verify(() => mockDeleteTodo.call(todo.id)).called(1);
      },
    );

    blocTest<DeleteTaskBloc, DeleteTaskState>(
      'emits [DeleteTaskError] when DeleteTodoEvent is added and deleting todo fails',
      build: () {
        when(() => mockDeleteTodo.call(any())).thenThrow(Exception('Failed to delete todo'));
        return deleteTaskBloc;
      },
      act: (bloc) => bloc.add(const DeleteTodoEvent(todo)),
      expect: () => [
        const DeleteTaskError('Failed to delete todo'),
      ],
    );
  });
}
