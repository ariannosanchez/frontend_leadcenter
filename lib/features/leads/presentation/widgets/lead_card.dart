import 'package:flutter/material.dart';
import 'package:lead_center/features/leads/domain/domain.dart';

class LeadsCard extends StatelessWidget {

  final Lead lead;

  const LeadsCard ({
    super.key,
    required this.lead
  });

  @override
  Widget build(BuildContext context) {

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
        ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                        child: Text(lead.name[0], style: const TextStyle(color: Colors.black45, fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lead.phone, style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          Text(lead.name, style: TextStyle(color: Colors.grey[500])),
                        ],
                      ),
                    )
                  ],
                ) 
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200
                    ),
                    child: Text(lead.tag.name, style: const TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200
                    ),
                    child: Text(lead.stage.name, style: const TextStyle(color: Colors.black)),
                  )
                ],
              ),
              // Text(lead.user.fullName, style: TextStyle(color: Colors.grey.shade800, fontSize: 12))
            ],
          )
        ],
      ),
    );

    
  }
}