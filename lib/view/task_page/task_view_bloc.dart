import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:first_app/database/database.dart';
import 'package:first_app/main.dart';
import 'package:meta/meta.dart';

part 'task_view_event.dart';

part 'task_view_state.dart';

class TaskViewBloc extends Bloc<TaskViewEvent, TaskViewState> {
  TaskViewBloc() : super(const TaskViewState()) {
    on<ReadTaskDataTaskViewEvent>(_watchTaskData);
    on<CreateTaskDataTaskViewEvent>(_createTaskData);
    on<UpdateDataTaskViewEvent>(_updateTaskData);
  }

  Future<void> _watchTaskData(
      ReadTaskDataTaskViewEvent event, Emitter<TaskViewState> emit) async {
    await emit.forEach(todoDao.watchAllTasks(), onData: (List<Todo> data) {
      if(data.isEmpty) return state.copyWith(taskViewStateEnum: TaskViewStateEnum.empty);
       return state.copyWith(listTodo: data, taskViewStateEnum: TaskViewStateEnum.loaded);
     },);
  }

  Future<void> _createTaskData(
      CreateTaskDataTaskViewEvent event, Emitter<TaskViewState> emit) async {
    await todoDao.insertTask(
      TodosCompanion(title: Value(event.taskName), dueDate: Value(event.taskDueDate)),
    );

    final listData = await todoDao.readAllTask();
    print('listData $listData');
  }

  Future<void> _updateTaskData(
      UpdateDataTaskViewEvent event, Emitter<TaskViewState> emit) async {
    await todoDao.updateTask(event.todo);
  }
}
