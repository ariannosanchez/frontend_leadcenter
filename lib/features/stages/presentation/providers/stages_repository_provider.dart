import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
import 'package:lead_center/features/stages/domain/domain.dart';
import 'package:lead_center/features/stages/infrastructure/infrastructure.dart';

final stagesRepositoryProvider = Provider<StagesRepository>((ref) {

  final accessToken = ref.watch( authProvider ).user ?.token ?? '';

  final stagesRepository = StagesRepositoryImpl(
    StagesDatasourceImpl(accessToken: accessToken)
  );

  return stagesRepository;

});