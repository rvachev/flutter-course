import 'package:flutter_course/src/features/menu/models/dto/menu_category_dto.dart';
import 'package:flutter_course/src/features/menu/models/menu_category.dart';

extension CategoryMapper on MenuCategoryDto {
  MenuCategory toModel() {
    return const MenuCategory();
  }
}