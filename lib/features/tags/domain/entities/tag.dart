import 'package:lead_center/features/tag_categories/domain/domain.dart';

class Tag {
  int id;
  String name;
  TagCategory tagCategory;

  Tag({
    required this.id,
    required this.name,
    required this.tagCategory
  });
}