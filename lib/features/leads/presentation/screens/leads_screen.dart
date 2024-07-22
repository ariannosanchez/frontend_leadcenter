  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:go_router/go_router.dart';
  import 'package:lead_center/features/leads/presentation/delegates/search_lead_delegate.dart';
  import 'package:lead_center/features/leads/presentation/providers/providers.dart';
  import 'package:lead_center/features/leads/presentation/widgets/widgets.dart';
  import 'package:lead_center/features/shared/shared.dart';

  class LeadsScreen extends ConsumerWidget {
    const LeadsScreen({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final scaffoldKey = GlobalKey<ScaffoldState>();

      return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('Leads'), 
          actions: [
            IconButton(onPressed: () {

              final leadRepository = ref.read( leadsRepositoryProvider ); 

              showSearch(
                context: context,
                delegate: SearchLeadDelegate(
                  searchLeads: leadRepository.searchLeads
                )
              );
            },
            icon: const Icon(Icons.search_rounded)),
            IconButton(onPressed: () {
              // show modal button sheet
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 400,
                  );
                }
              );
            },
            icon: const Icon(Icons.filter_alt_outlined))
          ],
        ),
        body: const _LeadsView(),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Nuevo lead'),
          icon: const Icon(Icons.add),
          onPressed: () {
            context.push('/lead/new');
          },
        ),
      );
    }
  }

  class _LeadsView extends ConsumerStatefulWidget {
    const _LeadsView();

    @override
    _LeadsViewState createState() => _LeadsViewState();
  }

  class _LeadsViewState extends ConsumerState {

    final ScrollController scrollController = ScrollController();

    @override
    void initState() {
      super.initState();

      scrollController.addListener((){
        if ( (scrollController.position.pixels + 400) >= scrollController.position.maxScrollExtent ){
          ref.read(leadsProvider.notifier).loadNextPage();
        }
      });

    }

    @override
    void dispose() {
      scrollController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      
      final leadsState = ref.watch( leadsProvider );

      print(leadsState.leads.length);

      return ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(20),
        itemCount: leadsState.leads.length,
        itemBuilder: (context, index) {
          final lead = leadsState.leads[index];
          return GestureDetector(
            onTap: () => context.push('/lead/${ lead.id }'),
            child: LeadsCard(lead: lead)
          );
        },
      );

      // return Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 10),
      //   child: MasonryGridView.count( 
      //     physics: const BouncingScrollPhysics(),
      //     crossAxisCount: 1,
      //     mainAxisSpacing: 20,
      //     crossAxisSpacing: 35,
      //     itemCount: leadsState.leads.length,
      //     itemBuilder: (context, index) {
      //       final lead = leadsState.leads[index];
      //       return LeadsCard(lead: lead);
      //     },
      //   ),
      // );
    }
  }
