import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:simple_to_do_app/domain/usecases/get_filtered_todo.dart';

import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/get_todo.dart';

part 'filter_task_event.dart';
part 'filter_task_state.dart';

class FilterTaskBloc extends HydratedBloc<FilterTaskEvent, FilterTaskState> {
  final GetFilteredTodos getFilteredTodos;
  final GetTodos getTodos;


  List<Todo> _allTodos = [];

  FilterTaskBloc(this.getFilteredTodos, this.getTodos)
      : super( FilterTaskInitial()) {
    on<LoadFilterTodos>(_onFilterTodos);
  }

  Future<void> _onFilterTodos(LoadFilterTodos event, Emitter<FilterTaskState> emit) async {

    _allTodos = await getFilteredTodos(event.filter);

    if(_allTodos.isEmpty){
      emit(FilterTaskEmpty());
    }
    else{

      emit(FilterTaskLoaded(_allTodos));

    }

  }



  @override
  FilterTaskState? fromJson(Map<String, dynamic> json) {

    print("fromJsonCalledFilter");
    print(json);
    if (json['data'] != null && (json['data'] as List<dynamic>).isNotEmpty) {
      _allTodos=(json['data'] as List<dynamic>)
          .map((e) => Todo.fromJson(e))
          .toList();

       getTodos(_allTodos);

      return FilterTaskLoaded(_allTodos);
    }
    return FilterTaskInitial();
  }

  @override
  Map<String, dynamic>? toJson(FilterTaskState state) {
    print("tojsonCalledFilter");
    print(state);

    if (state is FilterTaskLoaded) {
      print(state.todos);

      return {'data': state.todos.map((e) => e.toJson()).toList()};
    }
    return {'data': []};
  }
}
