import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
import 'package:lead_center/features/tags/domain/domain.dart';
import 'package:lead_center/features/tags/infrastructure/infrastructure.dart';

final tagsRepositoryProvider = Provider<TagsRepository>((ref) {
  
  final accessToken = ref.watch( authProvider ).user?.token ?? '';

  final tagsRepository = TagsRepositoryImpl(
    TagsDatasourceImpl(accessToken: accessToken)
  );

  return tagsRepository;
});