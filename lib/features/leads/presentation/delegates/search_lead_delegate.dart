import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/leads/presentation/widgets/widgets.dart';

typedef SearchLeadsCallback = Future<List<Lead>> Function(String query);

class SearchLeadDelegate extends SearchDelegate<Lead?> {
  final SearchLeadsCallback searchLeads;

  SearchLeadDelegate({required this.searchLeads});

  @override
  String get searchFieldLabel => 'Buscar lead';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // if ( query.isNotEmpty )
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchLeads(query),
      builder: (context, snapshot) {
        final leads = snapshot.data ?? [];

        return ListView.builder(
          itemCount: leads.length,
          itemBuilder: (context, index) => LeadsCard(lead: leads[index]),
          // final lead = leads[index];
        );
      },
    );
  }
}

class _LeadItem extends StatelessWidget {
  final Lead lead;

  const _LeadItem({required this.lead});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.2,
                child: CircleAvatar(
                  child: Text(lead.name[0],
                      style:
                          const TextStyle(color: Colors.black45, fontSize: 18)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(lead.phone), Text(lead.name)],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text('09/07/2024')],
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200),
                child: Text(lead.tag.name,
                    style: const TextStyle(color: Colors.black)),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue.shade50),
                child: Text(lead.stage.name,
                    style: const TextStyle(color: Colors.black)),
              ),
              const Spacer(),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text('Arianno Sanchez')],
              )
            ],
          ),
        ],
      ),
    );
  }
}
