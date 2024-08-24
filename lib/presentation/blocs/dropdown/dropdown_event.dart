// dropdown_event.dart
import 'package:equatable/equatable.dart';
import 'package:simple_to_do_app/presentation/blocs/filter_task/filter_task_bloc.dart';

abstract class DropdownEvent extends Equatable {
  const DropdownEvent();
}

class DropdownItemSelected extends DropdownEvent {
  final TodoFilter selectedItem;

  const DropdownItemSelected(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}
