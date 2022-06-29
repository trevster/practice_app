part of 'task_edit_cubit.dart';

class TaskEditState extends Equatable {
  final TodoWithCategory? todoWithCategory;
  final List<Category> categories;

  const TaskEditState({
    this.todoWithCategory,
    this.categories = const <Category>[],
  });

  TaskEditState copyWith({
    TodoWithCategory? todoWithCategory,
    List<Category>? categories,
  }) {
    return TaskEditState(
      todoWithCategory: todoWithCategory ?? this.todoWithCategory,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
        todoWithCategory,
        categories,
      ];
}
