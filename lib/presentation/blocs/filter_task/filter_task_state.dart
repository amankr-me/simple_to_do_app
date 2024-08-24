part of 'filter_task_bloc.dart';

abstract class FilterTaskState extends Equatable {

  const FilterTaskState();

  @override
  List<Object> get props => [];
}

class FilterTaskInitial extends FilterTaskState {}

class FilterTaskLoading extends FilterTaskState {}

class FilterTaskEmpty extends FilterTaskState {}


class FilterTaskLoaded extends FilterTaskState {
  final List<Todo> todos;
  final TodoFilter selectedFilter;

  const FilterTaskLoaded(this.todos,this.selectedFilter);

  @override
  List<Object> get props => [todos];
}

class FilterTaskError extends FilterTaskState {
  final String message;

  const FilterTaskError(this.message);

  @override
  List<Object> get props => [message];
}


