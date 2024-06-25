

import 'package:lead_center/features/auth/infraestructure/infraestructure.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/states/infrastructure/infrastructure.dart';
import 'package:lead_center/features/tags/infrastructure/infrastructure.dart';

class LeadMapper {
  
  static leadJsonToEntity( Map<String, dynamic> json )=> Lead(
    id: json['id'],
    name: json['name'],
    lastName: json['lastName'],
    email: json['email'],
    phone: json['phone'],
    slug: json['slug'],
    tag: TagMapper.tagJsonToEntity( json['tag'] ),
    state: StateMapper.stateJsonToEntity( json['state'] ),
    user: UserMapper.userJsonToEntity( json['user'] ),
  );
}