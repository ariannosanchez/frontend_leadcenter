import 'package:lead_center/features/tag_categories/domain/domain.dart';

class TagCategoryMapper {
   
  static TagCategory tagCategoryJsonToEntity( Map<String, dynamic> json ) => TagCategory(
    id: json['id'],
    name: json['name'],
  );

}