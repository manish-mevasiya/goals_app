import 'package:flutter/material.dart';

class PeopleTabView extends StatelessWidget {
  final String searchQuery;

  const PeopleTabView({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    // Contact profiles list matching the mockup
    final List<Map<String, dynamic>> people = [
      {
        "name": "Marcus Lee",
        "company": "Riverside Financial Group",
        "initials": "ML",
        "color": const Color(0xFF10B981), // Green
        "stage": "Prospect",
        "stageColor": const Color(0xFF10B981),
        "info": "BW · 3d ago",
        "hasAlert": false,
      },
      {
        "name": "Sara Kim",
        "company": "Clearview Dental Associates",
        "initials": "SK",
        "color": const Color(0xFF8B5CF6), // Purple
        "stage": "Prospect",
        "stageColor": const Color(0xFF10B981),
        "info": "RH · 1d ago",
        "hasAlert": false,
      },
      {
        "name": "Tara Nguyen",
        "company": "Apex Holdings LLC",
        "initials": "TN",
        "color": const Color(0xFFF59E0B), // Orange
        "stage": "Contact Made",
        "stageColor": const Color(0xFFF59E0B),
        "info": "8d ago",
        "hasAlert": true,
      },
      {
        "name": "David Park",
        "company": "Summit Credit Union",
        "initials": "DP",
        "color": const Color(0xFF3B82F6), // Blue
        "stage": "Contact Made",
        "stageColor": const Color(0xFF3B82F6),
        "info": "BW · 5d ago",
        "hasAlert": false,
      },
      {
        "name": "Linda Walsh",
        "company": "Northgate Realty Group",
        "initials": "LW",
        "color": const Color(0xFF6366F1), // Indigo
        "stage": "Contact Made",
        "stageColor": const Color(0xFF6366F1),
        "info": "DS · 2d ago",
        "hasAlert": false,
      },
      {
        "name": "Angela Ross",
        "company": "Harborview Medical Center",
        "initials": "AR",
        "color": const Color(0xFFA855F7), // Light purple
        "stage": "Docs Collected",
        "stageColor": const Color(0xFF10B981), // Greenish teal badge
        "info": "RH · 4d ago",
        "hasAlert": false,
      },
      {
        "name": "Mike Flores",
        "company": "Prestige Auto Group",
        "initials": "MF",
        "color": const Color(0xFFF59E0B), // Orange
        "stage": "Docs Collected",
        "stageColor": const Color(0xFF10B981),
        "info": "11d ago",
        "hasAlert": true,
      },
    ];

    // Filter people list based on searchQuery
    final List<Map<String, dynamic>> filteredPeople = people.where((person) {
      final name = (person["name"] as String).toLowerCase();
      final company = (person["company"] as String).toLowerCase();
      final query = searchQuery.toLowerCase();
      return name.contains(query) || company.contains(query);
    }).toList();

    if (filteredPeople.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 8),
              Text(
                "No people found matching '$searchQuery'",
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
        itemCount: filteredPeople.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: Color(0xFFF1F5F9),
        ),
        itemBuilder: (context, index) {
          final person = filteredPeople[index];
          final Color initialsColor = person["color"] as Color;
          final Color stageColor = person["stageColor"] as Color;
          final bool hasAlert = person["hasAlert"] as bool;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                // Initials Avatar
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: initialsColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    person["initials"] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Name & Company Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person["name"] as String,
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        person["company"] as String,
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

                // Stage Pill & Time update
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Stage Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: stageColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        person["stage"] as String,
                        style: TextStyle(
                          color: stageColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Time details (with potential alert icon)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          person["info"] as String,
                          style: TextStyle(
                            color: hasAlert ? const Color(0xFFEF4444) : Colors.blueGrey.shade300,
                            fontWeight: hasAlert ? FontWeight.bold : FontWeight.normal,
                            fontSize: 11,
                          ),
                        ),
                        if (hasAlert) ...[
                          const SizedBox(width: 3),
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFEF4444),
                            size: 13,
                          ),
                        ],
                      ],
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
