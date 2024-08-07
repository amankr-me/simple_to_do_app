import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/data/repositories/todo_repository.dart';
import 'package:simple_to_do_app/domain/entities/todo.dart';
import 'package:simple_to_do_app/presentation/blocs/filter_task/filter_task_bloc.dart';

void main() {
  late TodoRepositoryImpl todoRepository;

  setUp(() {
    todoRepository = TodoRepositoryImpl();
  });

  group('TodoRepositoryImpl', () {
    test('should add a todo', () async {
      // Arrange
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        completed: false,
      );

      // Act
      await todoRepository.addTodo(todo);

      // Assert
      final todos = await todoRepository.getFilterTodos(TodoFilter.all);
      expect(todos, contains(todo));
    });

    test('should update a todo', () async {
      // Arrange
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        completed: false,
      );
      await todoRepository.addTodo(todo);

      final updatedTodo = todo.copyWith(title: 'Updated Todo', completed: true);

      // Act
      await todoRepository.updateTodo(updatedTodo);

      // Assert
      final todos = await todoRepository.getFilterTodos(TodoFilter.all);
      expect(todos, contains(updatedTodo));
      expect(todos, isNot(contains(todo)));
    });

    test('should delete a todo', () async {
      // Arrange
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        completed: false,
      );
      await todoRepository.addTodo(todo);

      // Act
      await todoRepository.delete(todo.id);

      // Assert
      final todos = await todoRepository.getFilterTodos(TodoFilter.all);
      expect(todos, isNot(contains(todo)));
    });

    test('should filter todos by completed status', () async {
      // Arrange
      final completedTodo = Todo(
        id: '1',
        title: 'Completed Todo',
        completed: true,
      );
      final pendingTodo = Todo(
        id: '2',
        title: 'Pending Todo',
        completed: false,
      );
      await todoRepository.addTodo(completedTodo);
      await todoRepository.addTodo(pendingTodo);

      // Act
      final completedTodos = await todoRepository.getFilterTodos(TodoFilter.completed);
      final pendingTodos = await todoRepository.getFilterTodos(TodoFilter.pending);

      // Assert
      expect(completedTodos, contains(completedTodo));
      expect(completedTodos, isNot(contains(pendingTodo)));
      expect(pendingTodos, contains(pendingTodo));
      expect(pendingTodos, isNot(contains(completedTodo)));
    });
  });
}
