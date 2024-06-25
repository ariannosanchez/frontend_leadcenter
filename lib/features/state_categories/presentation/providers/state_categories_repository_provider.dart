import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
import 'package:lead_center/features/state_categories/domain/domain.dart';
import 'package:lead_center/features/state_categories/infrastructure/infrastructure.dart';

final stateCategoriesRepositoryProvider = Provider<StateCategoriesRepository>((ref){
  
  final accessToken = ref.watch( authProvider ).user?.token ?? '';

  final stateCategoriesRepository = StateCategoriesRepositoryImpl(
    StateCategoriesDatasourceImpl(accessToken: accessToken)
  );

  return stateCategoriesRepository;
});
