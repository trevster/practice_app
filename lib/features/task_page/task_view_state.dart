part of 'task_view_bloc.dart';

enum TaskViewStateEnum {
  empty,
  loading,
  loaded,
  error,
}

class TaskViewState extends Equatable {
  final List<TodoWithCategory> listTodoWithCategory;
  final TaskViewStateEnum taskViewStateEnum;

  const TaskViewState({
    this.listTodoWithCategory = const [],
    this.taskViewStateEnum = TaskViewStateEnum.empty,
  });

  TaskViewState copyWith({
    List<TodoWithCategory>? listTodoWithCategory,
    TaskViewStateEnum? taskViewStateEnum,
  }) {
    return TaskViewState(
      listTodoWithCategory: listTodoWithCategory ?? this.listTodoWithCategory,
      taskViewStateEnum: taskViewStateEnum ?? this.taskViewStateEnum,
    );
  }

  @override
  List<Object?> get props => [listTodoWithCategory];
}
