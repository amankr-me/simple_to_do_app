// import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
// part 'todo.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  final String id;
  final String title;
  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  // Method to copy the Todo with updated properties
  Todo copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object> get props => [id, title, completed];

  factory Todo.fromJson(Map<String,dynamic> json) =>  Todo(
    id: json['id'] as String,
    title: json['title'] as String,
    completed: json['completed'] as bool,
  );

  Map<String,dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'completed': completed,
  };
}
