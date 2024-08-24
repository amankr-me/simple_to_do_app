// import 'package:bloc_test/bloc_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:simple_to_do_app/domain/entities/todo.dart';
// import 'package:simple_to_do_app/domain/usecases/get_filtered_todo.dart';
// import 'package:simple_to_do_app/presentation/blocs/filter_task/filter_task_bloc.dart';
//
// class MockGetFilteredTodos extends Mock implements GetFilteredTodos {}
//
// void main() {
//   late FilterTaskBloc filterTaskBloc;
//   late MockGetFilteredTodos mockGetFilteredTodos;
//
//     setUpAll(() {
//       registerFallbackValue(TodoFilter.all);
//     });
//
//
//     setUp(() {
//     mockGetFilteredTodos = MockGetFilteredTodos();
//     filterTaskBloc = FilterTaskBloc(mockGetFilteredTodos);
//   });
//
//
//   group('LoadFilterTodos', () {
//     final filteredTodos = [const Todo(id: '1', title: 'Filtered Todo', completed: false)];
//
//     blocTest<FilterTaskBloc, FilterTaskState>(
//       'emits [FilterTaskLoaded] when LoadFilterTodos is added and todos are filtered',
//       build: () {
//         when(() => mockGetFilteredTodos(any())).thenAnswer((_) async => filteredTodos);
//         return filterTaskBloc;
//       },
//       act: (bloc) => bloc.add(LoadFilterTodos(TodoFilter.pending)),
//       expect: () => [
//         FilterTaskLoaded(filteredTodos),
//       ],
//     );
//
//     blocTest<FilterTaskBloc, FilterTaskState>(
//       'emits [FilterTaskEmpty] when LoadFilterTodos is added and no todos match filter',
//       build: () {
//         when(() => mockGetFilteredTodos(any())).thenAnswer((_) async => []);
//         return filterTaskBloc;
//       },
//       act: (bloc) => bloc.add(LoadFilterTodos(TodoFilter.completed)),
//       expect: () => [
//         FilterTaskEmpty(),
//       ],
//     );
//   });
// }
