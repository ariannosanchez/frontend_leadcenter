import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
import 'package:lead_center/features/tag_categories/domain/domain.dart';
import 'package:lead_center/features/tag_categories/infrastructure/infrastructure.dart';

final tagCategoriesRepositoryProvider = Provider<TagCategoriesRepository>((ref){

  final accessToken = ref.watch( authProvider ).user?.token ?? '';

  final tagCategoriesRepository = TagCategoriesRepositoryImpl(
    TagCategoriesDatasourceImpl(accessToken: accessToken)
  );

  return tagCategoriesRepository;
});