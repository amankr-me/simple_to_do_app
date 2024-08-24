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
  const FilterTaskLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}


class FilterTaskError extends FilterTaskState {
  final String message;

  const FilterTaskError(this.message);

  @override
  List<Object> get props => [message];



}


