import 'package:lead_center/features/auth/domain/domain.dart';
import 'package:lead_center/features/stages/domain/domain.dart';
import 'package:lead_center/features/tags/domain/domain.dart';

class Lead {
  String id;
  String name;
  String lastName;
  String email;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  Tag tag;
  Stage stage;
  User? user;

  Lead({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.tag,
    required this.stage,
    this.user,
  });

}
