import 'package:flutter/material.dart';

class MyDealsView extends StatelessWidget {
  const MyDealsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Teammate & deals data matching the mockup
    final List<Map<String, dynamic>> deals = [
      {
        "title": "Clearview Dental — Employee Plan",
        "stage": "Contact Made",
        "age": "7d",
        "value": "\$78K",
        "color": const Color(0xFF3B82F6), // Blue
      },
      {
        "title": "Metro Schools — Staff Benefits",
        "stage": "Docs Stage",
        "age": "2d",
        "value": "\$115K",
        "color": const Color(0xFFF59E0B), // Orange
      },
      {
        "title": "Summit Credit Union",
        "stage": "Prospect",
        "age": "12d",
        "value": "\$95K",
        "color": const Color(0xFF10B981), // Green
      },
      {
        "title": "Northview Law Group",
        "stage": "Payment",
        "age": "1d",
        "value": "\$60K",
        "color": const Color(0xFFEF4444), // Red
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. KPI Cards Row
          Row(
            children: [
              Expanded(
                child: _buildKpiCard("MY PIPELINE", "\$348K"),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildKpiCard("OPEN DEALS", "4"),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildKpiCard(
                  "WIN RATE",
                  "68%",
                  valueColor: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 2. Deals List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: deals.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final deal = deals[index];
              final Color badgeColor = deal["color"] as Color;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Value Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            deal["title"] as String,
                            style: const TextStyle(
                              color: Color(0xFF1E293B),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          deal["value"] as String,
                          style: const TextStyle(
                            color: Color(0xFF10B981), // green value
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Subtitle (Stage + Age)
                    Text(
                      "${deal["stage"]} · ${deal["age"]}",
                      style: TextStyle(
                        color: Colors.blueGrey.shade400,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Stage Pill Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        deal["stage"] as String,
                        style: TextStyle(
                          color: badgeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildKpiCard(String label, String value, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey.shade300,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? const Color(0xFF1E293B),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
