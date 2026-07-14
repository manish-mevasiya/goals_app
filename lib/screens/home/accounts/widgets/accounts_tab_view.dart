import 'package:flutter/material.dart';

class AccountsTabView extends StatelessWidget {
  final String searchQuery;

  const AccountsTabView({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    // Organizations list matching the mockup
    final List<Map<String, dynamic>> accounts = [
      {
        "name": "Riverside Financial Group",
        "industry": "Finance",
        "peopleCount": 1,
        "oppCount": 1,
        "value": "\$92K",
        "owner": "BW",
        "color": const Color(0xFF10B981), // Green
      },
      {
        "name": "Apex Holdings LLC",
        "industry": "Holdings",
        "peopleCount": 1,
        "oppCount": 1,
        "value": "\$145K",
        "owner": "8d stale",
        "color": const Color(0xFFF59E0B), // Orange
      },
      {
        "name": "Harborview Medical Center",
        "industry": "Healthcare",
        "peopleCount": 1,
        "oppCount": 1,
        "value": "\$158K",
        "owner": "RH",
        "color": const Color(0xFF6366F1), // Indigo
      },
      {
        "name": "Lakewood Builders Inc.",
        "industry": "Construction",
        "peopleCount": 1,
        "oppCount": 1,
        "value": "\$174K",
        "owner": "DS",
        "color": const Color(0xFF10B981), // Green
      },
      {
        "name": "Cascade Logistics Partners",
        "industry": "Logistics",
        "peopleCount": 1,
        "oppCount": 1,
        "value": "\$138K",
        "owner": "RH",
        "color": const Color(0xFF8B5CF6), // Purple
      },
    ];

    // Filter accounts list based on searchQuery
    final List<Map<String, dynamic>> filteredAccounts = accounts.where((acc) {
      final name = (acc["name"] as String).toLowerCase();
      final industry = (acc["industry"] as String).toLowerCase();
      final query = searchQuery.toLowerCase();
      return name.contains(query) || industry.contains(query);
    }).toList();

    if (filteredAccounts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 8),
              Text(
                "No accounts found matching '$searchQuery'",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: .zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filteredAccounts.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: Color(0xFFF1F5F9),
        ),
        itemBuilder: (context, index) {
          final acc = filteredAccounts[index];
          final Color iconColor = acc["color"] as Color;
          final String ownerText = acc["owner"] as String;
          final bool isStale = ownerText.contains("stale");

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                // Organization Briefcase Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: iconColor.withValues(alpha: 0.16),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.business_center_outlined,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Company Title & Industry/Stats
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        acc["name"] as String,
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${acc["industry"]} · ${acc["peopleCount"]} person · ${acc["oppCount"]} opp",
                        style: TextStyle(
                          color: Colors.blueGrey.shade300,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Value and Owner Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      acc["value"] as String,
                      style: const TextStyle(
                        color: Color(0xFF10B981), // mockup green
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ownerText,
                      style: TextStyle(
                        color: isStale ? const Color(0xFFEF4444) : Colors.blueGrey.shade300,
                        fontWeight: isStale ? FontWeight.bold : FontWeight.normal,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
