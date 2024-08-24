import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_to_do_app/presentation/blocs/filter_task/filter_task_bloc.dart';

import '../blocs/dropdown/dropdown_bloc.dart';
import '../blocs/dropdown/dropdown_event.dart';
import '../blocs/dropdown/dropdown_state.dart';

class DropdownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownBloc, DropdownState>(
      builder: (context, state) {
        return DropdownButton<TodoFilter>(
          value: state.selectedItem,
          items: state.items
              .map((item) => DropdownMenuItem(
            value: item,
            child: Text(item.name.toUpperCase()),
          ))
              .toList(),
          onChanged: (selectedItem) {
            if (selectedItem != null) {
              context.read<DropdownBloc>().add(DropdownItemSelected(selectedItem));
              context
                  .read<FilterTaskBloc>()
                  .add(LoadFilterTodos(selectedItem));
            }
          },
        );
      },
    );
  }
}
