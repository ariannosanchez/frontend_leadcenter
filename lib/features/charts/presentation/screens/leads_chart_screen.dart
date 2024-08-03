import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/charts/domain/domain.dart';
import 'package:lead_center/features/charts/presentation/providers/providers.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LeadsChartScreen extends StatelessWidget {
  const LeadsChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
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

    return SfFunnelChart(
      legend: const Legend(isVisible: true),
      series: FunnelSeries<LeadChart, String>(
        dataSource: leadsChartState.leadsChart,
        xValueMapper: (LeadChart data, _) => data.stage,
        yValueMapper: (LeadChart data, _) => data.count,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
      ),
    );
  }
}
