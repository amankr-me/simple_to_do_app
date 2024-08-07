import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel extends Equatable {
  final String id;
  final String title;
  final bool completed;

  const TodoModel({required this.id, required this.title, this.completed = false});

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  @override
  List<Object> get props => [id, title, completed];
}
