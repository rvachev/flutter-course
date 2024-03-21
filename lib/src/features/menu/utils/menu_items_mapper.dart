import 'package:flutter_course/src/features/menu/models/dto/menu_item_dto.dart';
import 'package:flutter_course/src/features/menu/models/menu_item.dart';

extension MenuItemsMapper on MenuItemDto {
  MenuItem toModel() {
    return const MenuItem();
  }
}