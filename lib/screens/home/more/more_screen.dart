import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Card 1 Items (Highlights, Chat, Ask Ace)
    final List<Map<String, dynamic>> card1Items = [
      {
        "title": "Highlights",
        "subtitle": "4 new recognitions",
        "icon": Icons.star_border_rounded,
        "color": const Color(0xFFF59E0B), // Orange/Yellow
      },
      {
        "title": "Chat",
        "subtitle": "2 unread messages",
        "icon": Icons.mode_comment_outlined,
        "color": const Color(0xFF3B82F6), // Blue
        "badgeCount": 2,
      },
      {
        "title": "Ask Ace",
        "subtitle": "AI sales coach",
        "icon": Icons.auto_awesome_outlined,
        "color": const Color(0xFF10B981), // Green
      },
    ];

    // Card 2 Items (Bonuses, Contests, Commissions, Reports, Forecasting)
    final List<Map<String, dynamic>> card2Items = [
      {
        "title": "Bonuses",
        "subtitle": "Jump into June active",
        "icon": Icons.card_giftcard_outlined,
        "color": const Color(0xFF10B981), // Green
      },
      {
        "title": "Contests",
        "subtitle": "1 active contest",
        "icon": Icons.bolt_outlined,
        "color": const Color(0xFFF59E0B), // Orange
      },
      {
        "title": "Commissions",
        "subtitle": "\$96,695 YTD",
        "icon": Icons.attach_money_outlined,
        "color": const Color(0xFF10B981), // Green
      },
      {
        "title": "Reports",
        "subtitle": "Sales analytics",
        "icon": Icons.insert_chart_outlined_rounded,
        "color": const Color(0xFF6366F1), // Indigo
      },
      {
        "title": "Forecasting",
        "subtitle": "Q3 projections",
        "icon": Icons.trending_up_rounded,
        "color": const Color(0xFFEF4444), // Red
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Title Header
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Text(
                  "More",
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),

              // 2. Card 1 list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildMenuCard(context, card1Items),
              ),
              const SizedBox(height: 16),

              // 3. Card 2 list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildMenuCard(context, card2Items),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, List<Map<String, dynamic>> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: Color(0xFFF1F5F9),
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          final Color iconColor = item["color"] as Color;
          final int? badgeCount = item["badgeCount"] as int?;

          return InkWell(
            onTap: () {
              // Click feedback toast
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Opened ${item["title"]}"),
                  duration: const Duration(seconds: 1),
                  backgroundColor: const Color(0xFF1E293B),
                ),
              );
            },
            borderRadius: BorderRadius.only(
              topLeft: index == 0 ? const Radius.circular(20) : Radius.zero,
              topRight: index == 0 ? const Radius.circular(20) : Radius.zero,
              bottomLeft: index == items.length - 1 ? const Radius.circular(20) : Radius.zero,
              bottomRight: index == items.length - 1 ? const Radius.circular(20) : Radius.zero,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  // Icon container with pastel background
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
                      item["icon"] as IconData,
                      color: iconColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Menu item Text (Title & Subtitle)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["title"] as String,
                          style: const TextStyle(
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item["subtitle"] as String,
                          style: TextStyle(
                            color: Colors.blueGrey.shade300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Right side: Badge count or Chevron icon
                  if (badgeCount != null)
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444), // red bubble
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        badgeCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    const Icon(
                      Icons.chevron_right,
                      color: Color(0xFFCBD5E1),
                      size: 20,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
