part of 'task_view_bloc.dart';

enum TaskViewStateEnum {
  empty,
  loading,
  loaded,
  error,
}

class TaskViewState extends Equatable {
  final List<Todo> listTodo;
  final TaskViewStateEnum taskViewStateEnum;

  const TaskViewState({
    this.listTodo = const [],
    this.taskViewStateEnum = TaskViewStateEnum.empty,
  });

  TaskViewState copyWith({
    List<Todo>? listTodo,
    TaskViewStateEnum? taskViewStateEnum,
  }) {
    return TaskViewState(
      listTodo: listTodo ?? this.listTodo,
      taskViewStateEnum: taskViewStateEnum ?? this.taskViewStateEnum,
    );
  }

  @override
  List<Object?> get props => [listTodo];
}
