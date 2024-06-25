import 'package:lead_center/features/tags/domain/domain.dart';
import 'package:lead_center/features/tag_categories/infrastructure/infrastructure.dart';

class TagMapper {

  static tagJsonToEntity( Map<String, dynamic> json ) => Tag(
    id: json['id'],
    name: json['name'],
    tagCategory: TagCategoryMapper
      .tagCategoryJsonToEntity( json['tagCategory'] ),
  );
}