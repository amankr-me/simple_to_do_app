// dropdown_state.dart
import 'package:equatable/equatable.dart';
import 'package:simple_to_do_app/presentation/blocs/filter_task/filter_task_bloc.dart';

class DropdownState extends Equatable {
  final List<TodoFilter> items;
  final TodoFilter selectedItem;

  const DropdownState({
    required this.items,
    required this.selectedItem,
  });

  @override
  List<Object> get props => [items, selectedItem];
}
