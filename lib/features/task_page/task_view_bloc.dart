import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:first_app/database/database.dart';
import 'package:first_app/features/appEntry.dart';
import 'package:first_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'task_view_event.dart';

part 'task_view_state.dart';

class TaskViewBloc extends Bloc<TaskViewEvent, TaskViewState> {
  TaskViewBloc() : super(const TaskViewState()) {
    on<ReadTaskDataTaskViewEvent>(_watchTaskData);
    on<CreateTaskDataTaskViewEvent>(_createTaskData);
    on<UpdateDataTaskViewEvent>(_updateTaskData);
  }

  final todoDao = database.todoDao;

  Future<void> _watchTaskData(ReadTaskDataTaskViewEvent event, Emitter<TaskViewState> emit) async {
    await emit.forEach(
      todoDao.watchAllTasks(),
      onData: (List<TodoWithCategory> data) {
        if (data.isEmpty) return state.copyWith(taskViewStateEnum: TaskViewStateEnum.empty);
        return state.copyWith(listTodoWithCategory: data, taskViewStateEnum: TaskViewStateEnum.loaded);
      },
    );
  }

  Future<void> _createTaskData(CreateTaskDataTaskViewEvent event, Emitter<TaskViewState> emit) async {
    await todoDao.insertTask(
      TodosCompanion(title: Value(event.taskName), dueDate: Value(event.taskDueDate)),
    );
  }

  Future<void> _updateTaskData(UpdateDataTaskViewEvent event, Emitter<TaskViewState> emit) async {
    if(event.todo == null) return;
    final Todo todo = event.todo!.copyWith(completed: !event.todo!.completed);
    await todoDao.updateTask(todo);
  }
}
