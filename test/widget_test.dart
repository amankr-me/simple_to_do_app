import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_to_do_app/data/repositories/todo_repository.dart';
import 'package:simple_to_do_app/domain/entities/todo.dart';
import 'package:simple_to_do_app/domain/usecases/add_todo.dart';
import 'package:simple_to_do_app/domain/usecases/delete_todo.dart';
import 'package:simple_to_do_app/domain/usecases/get_filtered_todo.dart';
import 'package:simple_to_do_app/domain/usecases/update_todo.dart';
import 'package:simple_to_do_app/presentation/blocs/add_task/add_task_bloc.dart';
import 'package:simple_to_do_app/presentation/blocs/delete_task/delete_task_bloc.dart';
import 'package:simple_to_do_app/presentation/blocs/filter_task/filter_task_bloc.dart';
import 'package:simple_to_do_app/presentation/blocs/update_task/update_task_bloc.dart';
import 'package:simple_to_do_app/presentation/screens/todo_screen.dart';

class MockGetFilteredTodos extends Mock implements GetFilteredTodos {}
class MockAddTodo extends Mock implements AddTodo {}
class MockUpdateTodo extends Mock implements UpdateTodo {}
class MockDeleteTodo extends Mock implements DeleteTodo {}
class MockTaskRepositoryImpl extends Mock implements TodoRepositoryImpl {}

class FakeTodo extends Fake implements Todo {}
class FakeUpdateTodoEvent extends Fake implements UpdateTodoEvent {}

void main() {
  late MockGetFilteredTodos mockGetFilteredTodos;
  late MockAddTodo mockAddTodo;
  late MockUpdateTodo mockUpdateTodo;
  late MockDeleteTodo mockDeleteTodo;
  setUpAll(() {
    registerFallbackValue(const Todo(
      id: '1',
      title: 'Test Todo',
      completed: false,
    ));
    registerFallbackValue(FakeTodo());
    registerFallbackValue(FakeUpdateTodoEvent());

  });

  setUp(() {
    mockGetFilteredTodos = MockGetFilteredTodos();
    mockAddTodo = MockAddTodo();
    mockUpdateTodo = MockUpdateTodo();
    mockDeleteTodo = MockDeleteTodo();

  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddTaskBloc>(
          create: (BuildContext context) => AddTaskBloc(mockAddTodo),
        ),
        BlocProvider<DeleteTaskBloc>(
          create: (BuildContext context) => DeleteTaskBloc(mockDeleteTodo),
        ),
        BlocProvider<UpdateTaskBloc>(
          create: (BuildContext context) => UpdateTaskBloc(mockUpdateTodo),
        ),
        // BlocProvider<FilterTaskBloc>(
        //   create: (BuildContext context) => FilterTaskBloc(mockGetFilteredTodos)..add(LoadFilterTodos(TodoFilter.all)),
        // ),
      ],
      child: const MaterialApp(
        home: TodoScreen(),
      ),
    );
  }



  testWidgets('displays initial state with no todos', (WidgetTester tester) async {
    // Arrange
    when(() => mockGetFilteredTodos(TodoFilter.all)).thenAnswer((_) async => []);

    // Build the widget tree
    await tester.pumpWidget(createWidgetUnderTest());

    // Act
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('No todos available'), findsOneWidget);
  });

  testWidgets('adds a new todo', (WidgetTester tester) async {
    // Arrange
    when(() => mockGetFilteredTodos(TodoFilter.all)).thenAnswer((_) async => []);
    when(() => mockAddTodo(any())).thenAnswer((_) async => {});
    when(() => mockGetFilteredTodos(TodoFilter.all)).thenAnswer((_) async => [const Todo(
      id: '1',
      title: 'New Todo',
      completed: false,
    )]);

    // Build the widget tree
    await tester.pumpWidget(createWidgetUnderTest());

    // Act
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Enter text and add a todo
    await tester.enterText(find.byType(TextField), 'New Todo');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Debugging: Print widget tree to see what is actually rendered
    final textFinder = find.text('New Todo');
    if (kDebugMode) {
      print('Debug text finder: $textFinder');
    }

    // Assert
    expect(textFinder, findsOneWidget, reason: 'Expected to find "New Todo" text widget.');
  });


}
