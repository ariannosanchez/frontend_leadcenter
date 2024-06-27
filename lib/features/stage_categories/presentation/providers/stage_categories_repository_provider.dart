import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
import 'package:lead_center/features/stage_categories/domain/domain.dart';
import 'package:lead_center/features/stage_categories/infrastructure/infrastructure.dart';

final stageCategoriesRepositoryProvider = Provider<StageCategoriesRepository>((ref){

  final accessToken = ref.watch( authProvider ).user?.token ?? '';

  final stageCategoriesRepository = StageCategoriesRepositoryImpl(
    StageCategoriesDatasourceImpl(accessToken: accessToken)
  );

  return stageCategoriesRepository;
});