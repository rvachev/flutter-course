import 'package:flutter_course/src/features/menu/data/data_sources/menu_data_source.dart';
import 'package:flutter_course/src/features/menu/models/dto/menu_item_dto.dart';

abstract interface class ISavableMenuDataSource implements IMenuDataSource {
  Future<void> saveMenuItems({required List<MenuItemDto> menuItems});
}

final class DbMenuDataSource implements ISavableMenuDataSource {
  // Put dependency of network class such as dio or http, e.g.
  // final IMenuDb _menuDb;

  const DbMenuDataSource(/*{required IMenuDb menuDb}*/)/* : _menuDb = menuDb*/;

  @override
  Future<List<MenuItemDto>> fetchMenuItems({required String categoryId, int page = 0, int limit = 25}) {
    // TODO: implement fetchMenuItems
    throw UnimplementedError();
  }

  @override
  Future<void> saveMenuItems({required List<MenuItemDto> menuItems}) {
    // TODO: implement saveMenuItems
    throw UnimplementedError();
  }
}
