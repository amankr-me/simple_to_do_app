import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_to_do_app/domain/usecases/get_filtered_todo.dart';

import '../../../domain/entities/todo.dart';

part 'filter_task_event.dart';
part 'filter_task_state.dart';

class FilterTaskBloc extends Bloc<FilterTaskEvent, FilterTaskState> {
  final GetFilteredTodos getFilteredTodos;


  List<Todo> _allTodos = [];

  FilterTaskBloc(this.getFilteredTodos, )
      : super(FilterTaskInitial()) {
    // on<LoadTodos>(_onLoadTodos);
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
}
