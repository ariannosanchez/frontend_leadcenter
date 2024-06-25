import 'package:lead_center/features/state_categories/domain/domain.dart';

class State {
  int id;
  String name;
  StateCategory stateCategory;

  State({
    required this.id,
    required this.name,
    required this.stateCategory
  });
}