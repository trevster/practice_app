import 'package:first_app/features/task_edit_page/task_edit_view.dart';
import 'package:first_app/features/task_page/task_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TaskViewBloc _taskViewBloc;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _taskViewBloc = TaskViewBloc();
    _taskViewBloc.add(ReadTaskDataTaskViewEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 60,
            child: BlocConsumer<TaskViewBloc, TaskViewState>(
              bloc: _taskViewBloc,
              builder: (_, state) {
                if (state.taskViewStateEnum == TaskViewStateEnum.loaded) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: state.listTodoWithCategory.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(state.listTodoWithCategory[index].todo?.title ?? ''),
                        subtitle: Text(state.listTodoWithCategory[index].category?.name ?? ''),
                        trailing: Checkbox(
                          value: state.listTodoWithCategory[index].todo?.completed,
                          onChanged: (_) => _taskViewBloc.add(UpdateDataTaskViewEvent(state.listTodoWithCategory[index].todo)),
                        ),
                        onTap: () => _taskViewBloc.add(UpdateDataTaskViewEvent(state.listTodoWithCategory[index].todo)),
                        onLongPress: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => TaskEditView(todoWithCategory: state.listTodoWithCategory[index]))),
                      );
                    },
                  );
                }
                return Center(
                    child: Container(
                  child: Text('No Task'),
                ));
              },
              listener: (_, __) {},
            ),
          ),
          Positioned(
            right: 10,
            left: 10,
            bottom: 10,
            child: Container(
              color: Colors.grey.withOpacity(0.2),
              child: TextField(
                controller: _textEditingController,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  _taskViewBloc.add(CreateTaskDataTaskViewEvent(taskName: value));
                  _textEditingController.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
