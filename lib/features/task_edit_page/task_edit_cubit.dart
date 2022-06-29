import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:first_app/database/database.dart';
import 'package:first_app/features/appEntry.dart';

part 'task_edit_state.dart';

class TaskEditCubit extends Cubit<TaskEditState> {
  TaskEditCubit() : super(TaskEditState());

  final _categoryDao = database.categoryDao;
  final _todoDao = database.todoDao;

  // Category Dao

  void watchCategoryData() {
    _categoryDao.watchAllTasks().listen((List<Category> event) => emit(state.copyWith(categories: event)));
  }

  Future<void> createCategoryData(Category category) async {
    await _categoryDao.insertTask(CategoriesCompanion(name: Value(category.name), color: Value(0)));
  }

  Future<void> updateCategoryData(Category category) async {
    await _categoryDao.updateTask(category);
  }

  // TodoDao

  Future<void> watchSingleTodo({Todo? todo}) async {
    if (todo == null) return;
    _todoDao.watchSpecificTask(todo).listen((TodoWithCategory t) => emit(state.copyWith(todoWithCategory: t)));
  }

  Future<void> updateTodoData({Todo? todo, String? todoTitle, String? categoryName}) async {
    if (todo == null) return;
    await _todoDao.updateTask(todo.copyWith(
      title: todoTitle,
      category: categoryName,
    ));
  }
}
