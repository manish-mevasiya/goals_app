import 'package:flutter/material.dart';

class MyAccountsView extends StatelessWidget {
  final String searchQuery;

  const MyAccountsView({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    // Personal accounts data list matching the mockup
    final List<Map<String, dynamic>> myAccounts = [
      {
        "name": "Sarah Chen",
        "company": "Clearview Dental",
        "role": "Decision Maker",
        "dealStatus": "Active Deal · \$78K",
        "stage": "Active",
        "avatar": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150",
        "color": const Color(0xFF10B981), // Green
      },
      {
        "name": "James Hooper",
        "company": "Summit Credit Union",
        "role": "HR Director",
        "dealStatus": "Prospecting",
        "stage": "Prospect",
        "avatar": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150",
        "color": const Color(0xFFF59E0B), // Orange
      },
      {
        "name": "Lisa Park",
        "company": "Metro Schools",
        "role": "Benefits Admin",
        "dealStatus": "Docs Stage · \$115K",
        "stage": "In Progress",
        "avatar": "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150",
        "color": const Color(0xFF3B82F6), // Blue
      },
      {
        "name": "Kevin Marsh",
        "company": "Northview Law Group",
        "role": "Partner",
        "dealStatus": "Payment Pending · \$60K",
        "stage": "Payment",
        "avatar": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150",
        "color": const Color(0xFFEF4444), // Red
      },
    ];

    // Filter list based on query
    final List<Map<String, dynamic>> filtered = myAccounts.where((acc) {
      final name = (acc["name"] as String).toLowerCase();
      final company = (acc["company"] as String).toLowerCase();
      final role = (acc["role"] as String).toLowerCase();
      final query = searchQuery.toLowerCase();
      return name.contains(query) || company.contains(query) || role.contains(query);
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 8),
              Text(
                "No contacts found matching '$searchQuery'",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filtered.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final acc = filtered[index];
          final Color themeColor = acc["color"] as Color;
          final String initials = (acc["name"] as String)
              .split(" ")
              .map((e) => e.isNotEmpty ? e[0] : "")
              .join();

          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Client Face Avatar (with Initials Fallback)
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 48,
                    height: 48,
                    color: themeColor.withValues(alpha: 0.12),
                    child: Image.network(
                      acc["avatar"] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Center(
                        child: Text(
                          initials,
                          style: TextStyle(
                            color: themeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Contact Profile info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name & Stage Badge Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            acc["name"] as String,
                            style: const TextStyle(
                              color: Color(0xFF1E293B),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: themeColor.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              acc["stage"] as String,
                              style: TextStyle(
                                color: themeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),

                      // Company · Role
                      Text(
                        "${acc["company"]} · ${acc["role"]}",
                        style: TextStyle(
                          color: Colors.blueGrey.shade300,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Active Deal Status text
                      Text(
                        acc["dealStatus"] as String,
                        style: TextStyle(
                          color: themeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
