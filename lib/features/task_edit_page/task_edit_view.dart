import 'package:first_app/database/database.dart';
import 'package:first_app/features/task_edit_page/task_edit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskEditView extends StatelessWidget {
  final TodoWithCategory todoWithCategory;

  TaskEditView({Key? key, required this.todoWithCategory}) : super(key: key);

  final TextEditingController todoTEC = TextEditingController();
  final TextEditingController categoryTEC = TextEditingController();
  final TaskEditCubit taskEditCubit = TaskEditCubit();

  @override
  Widget build(BuildContext context) {

    todoTEC.text = todoWithCategory.todo?.title ?? '';
    taskEditCubit.watchSingleTodo(todo: todoWithCategory.todo);
    taskEditCubit.watchCategoryData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...taskPart(),
              ...partition(),
              ...categoryPart(context),
              ...partition(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> partition() => [
    const SizedBox(height: 20),
    const Divider(),
    const SizedBox(height: 20),
  ];

  List<Widget> taskPart() => [
    Text('Task'),
    TextField(
      controller: todoTEC,
      textInputAction: TextInputAction.done,
      onSubmitted: (String? value) {
        if (value == null || value.isEmpty) return;
        taskEditCubit.updateTodoData(
          todo: todoWithCategory.todo,
          todoTitle: value,
        );
      },
    ),
  ];

  List<Widget> categoryPart(BuildContext context) => [
    Text('Category'),
    Row(
      children: [
        BlocBuilder<TaskEditCubit, TaskEditState>(
          bloc: taskEditCubit,
          builder: (BuildContext context, TaskEditState state) {
            return DropdownButton(
              value: state.todoWithCategory?.category?.name,
              hint: Text('Choose Category'),
              disabledHint: Text('Please create a category'),
              items: state.categories.map((Category category) {
                return DropdownMenuItem(
                  value: category.name,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value == null || value.isEmpty) return;
                taskEditCubit.updateTodoData(
                  todo: state.todoWithCategory?.todo,
                  categoryName: value,
                );
              },
            );
          },
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add a new category'),
                    content: TextField(
                      controller: categoryTEC,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (categoryTEC.text.isEmpty) return;
                          taskEditCubit.createCategoryData(Category(name: categoryTEC.text));
                          categoryTEC.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text('Add'),
                      )
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.add)),
      ],
    ),
  ];
}
