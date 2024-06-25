import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/leads/infrastructure/infraestructure.dart';

final leadsRepositoryProvider = Provider<LeadsRepository>((ref) {

  final accessToken = ref.watch( authProvider ).user?.token ?? '';

  final leadsRepository = LeadsRepositoryImpl(
    LeadsDatasourceImpl(accessToken: accessToken)
  );

  return leadsRepository;
});

