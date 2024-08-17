import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lead_center/features/charts/domain/domain.dart';
import 'package:lead_center/features/charts/presentation/providers/providers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LeadsChartScreen extends StatelessWidget {
  const LeadsChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // drawer: SideMenu(scaffoldKey: scaffoldKey),
      // bottomNavigationBar: const CustomBottomNavigation(),
      appBar: AppBar(
        title: const Text('Embudo de ventas'),
      ),
      body: const _LeadsChartView(),
    );
  }
}

class _LeadsChartView extends ConsumerStatefulWidget {

  const _LeadsChartView();

  @override
  _LeadsChartViewState createState() => _LeadsChartViewState();
}

class _LeadsChartViewState extends ConsumerState {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final leadsChartState = ref.watch( leadsChartProvider );

    return RefreshIndicator(
      onRefresh: () async { 
        await ref.refresh(leadsChartProvider.notifier).loadReport();
       },
      child: SfFunnelChart(
        title: ChartTitle(
          text: 'Total Leads: ${leadsChartState.leadsChart.length}',
        ),
        legend: const Legend(isVisible: true),
        series: FunnelSeries<LeadChart, String>(
          gapRatio: 0.1,
          dataSource: leadsChartState.leadsChart,
          xValueMapper: (LeadChart data, _) => data.stage.name,
          yValueMapper: (LeadChart data, _) => data.count,
          dataLabelSettings: const DataLabelSettings(
            showZeroValue: false,
            isVisible: true,
          ),
          onPointTap: (ChartPointDetails details) {
            //TODO: Aqui enviaremos petición a traves del id de la etapa
            final selectedStage = leadsChartState.leadsChart[details.pointIndex!];
            context.push('/leads_stage/${selectedStage.stage.id}');
          },
        ),
      ),
    );
  }
}
