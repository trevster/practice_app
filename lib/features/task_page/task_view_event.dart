part of 'task_view_bloc.dart';

@immutable
abstract class TaskViewEvent {}

class CreateTaskDataTaskViewEvent extends TaskViewEvent{
  final String taskName;
  final DateTime? taskDueDate;
  CreateTaskDataTaskViewEvent({required this.taskName, this.taskDueDate});
}
class ReadTaskDataTaskViewEvent extends TaskViewEvent{}
class UpdateDataTaskViewEvent extends TaskViewEvent{
  final Todo? todo;
  UpdateDataTaskViewEvent(this.todo);
}
class DeleteDataTaskViewEvent extends TaskViewEvent{}
