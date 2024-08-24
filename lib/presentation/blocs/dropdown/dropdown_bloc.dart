// dropdown_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:simple_to_do_app/presentation/blocs/filter_task/filter_task_bloc.dart';
import 'dropdown_event.dart';
import 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc(List<TodoFilter> initialItems)
      : super(DropdownState(items: initialItems, selectedItem: initialItems[0])) {
    on<DropdownItemSelected>((event, emit) {
      emit(DropdownState(items: state.items, selectedItem: event.selectedItem));
    });
  }
}
