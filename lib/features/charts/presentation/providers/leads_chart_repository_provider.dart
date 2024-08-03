import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
import 'package:lead_center/features/charts/domain/domain.dart';
import 'package:lead_center/features/charts/infrastructure/infraestructure.dart';

final leadsChartRepositoryProvider = Provider<LeadsChartRepository>((ref) {

  final accessToken = ref.watch( authProvider ).user?.token ?? '';

  final leadsChartRepository = LeadsChartRepositoryImpl(
    LeadsChartDatasourceImpl(accessToken : accessToken)
  );

  return leadsChartRepository;

});