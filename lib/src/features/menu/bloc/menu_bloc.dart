import 'package:bloc/bloc.dart';
import 'package:flutter_course/src/features/menu/data/category_repository.dart';
import 'package:flutter_course/src/features/menu/data/menu_repository.dart';
import 'package:flutter_course/src/features/menu/models/menu_category.dart';
import 'package:flutter_course/src/features/menu/models/menu_item.dart';

part 'menu_event.dart';
part 'menu_state.dart';

const _pageLimit = 25;

final class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final IMenuRepository _menuRepository;
  final ICategoryRepository _categoryRepository;

  MenuBloc({
    required IMenuRepository menuRepository, 
    required ICategoryRepository categoryRepository,
  }) : _menuRepository = menuRepository, _categoryRepository = categoryRepository, super(const IdleMenuState()) {
    on<MenuEvent>((event, emit) {
      switch(event) {
        case LoadCategoriesEvent(): _loadCategories(event, emit);
        case LoadPageEvent(): _loadMenuItems(event, emit);
      }
    });
  }

  MenuCategory? _currentPaginatedCategory;
  final int _currentPage = 0;

  Future<void> _loadCategories(LoadCategoriesEvent event, Emitter<MenuState> emit) async {
    emit(ProgressMenuState(items: state.items));
    try {
      final categories = await _categoryRepository.loadCategories();
      emit(SuccessfulMenuState(categories: categories, items: List.empty()));
    } on Object {
      emit(ErrorMenuState(categories: state.categories, items: state.items));
      rethrow;
    } finally {
      emit(IdleMenuState(categories: state.categories, items: state.items));
    }
  }

  Future<void> _loadMenuItems(LoadPageEvent event, Emitter<MenuState> emit) async {
    _currentPaginatedCategory ??= state.categories?.first;
    if (_currentPaginatedCategory == null) return;

    emit(ProgressMenuState(items: state.items));
    try {
      final items = await _menuRepository.loadMenuItems(category: _currentPaginatedCategory!, page: _currentPage, limit: _pageLimit);
      if(items.length < _pageLimit) {
        // Обновить счетчик страниц и выбрать следующую категорию
      }
      emit(SuccessfulMenuState(categories: state.categories, items: items));
    } on Object {
      emit(ErrorMenuState(categories: state.categories, items: state.items));
      rethrow;
    } finally {
      emit(IdleMenuState(categories: state.categories, items: state.items));
    }
  }
}