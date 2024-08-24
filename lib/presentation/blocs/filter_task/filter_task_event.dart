part of 'filter_task_bloc.dart';


abstract class FilterTaskEvent extends Equatable {
  const FilterTaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends FilterTaskEvent {}

class LoadFilterTodos extends FilterTaskEvent {
  final TodoFilter filter;

  const LoadFilterTodos(this.filter);
}

class ChangeFilter extends FilterTaskEvent {
  final TodoFilter filter;

  const ChangeFilter(this.filter);
}

enum TodoFilter { all, completed, pending }