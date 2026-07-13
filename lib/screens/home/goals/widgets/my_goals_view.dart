import 'package:flutter/material.dart';

class MyGoalsView extends StatefulWidget {
  const MyGoalsView({super.key});

  @override
  State<MyGoalsView> createState() => _MyGoalsViewState();
}

class _MyGoalsViewState extends State<MyGoalsView> {
  String selectedFilter = "All";

  final List<String> filters = ["All", "On Track", "At Risk"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. My Annual Sales Goal Card
          _buildMyAnnualGoalCard(),
          const SizedBox(height: 20),

          // 2. Filter Pills
          _buildFilterPills(),
          const SizedBox(height: 16),

          // 3. Goal Cards List
          _buildGoalCardsList(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // --- My Annual Sales Goal Card ---
  Widget _buildMyAnnualGoalCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B2A4A), Color(0xFF121B2F)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MY ANNUAL SALES GOAL — 2026",
            style: TextStyle(
              color: Colors.blueGrey.shade300,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "\$2,400,000",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 16),
          // Badges Row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildBadge("\$1,248K Done", const Color(0xFF10B981)),
              _buildBadge("On Pace", const Color(0xFF3B82F6)),
            ],
          ),
          const SizedBox(height: 20),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 8,
              width: double.infinity,
              color: Colors.blueGrey.shade900,
              child: Row(
                children: [
                  Expanded(
                    flex: 52,
                    child: Container(color: const Color(0xFF10B981)),
                  ),
                  Expanded(
                    flex: 48,
                    child: Container(color: Colors.transparent),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Jan", style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text(
                "52%",
                style: TextStyle(
                  color: Color(0xFF10B981),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text("Dec", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  // --- Filter Pills ---
  Widget _buildFilterPills() {
    return Row(
      children: filters.map((filter) {
        bool isSelected = selectedFilter == filter;
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            showCheckmark: false,
            label: Text(filter),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  selectedFilter = filter;
                });
              }
            },
            selectedColor: const Color(0xFF10B981),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? Colors.transparent : Colors.grey.shade300,
              ),
            ),
            elevation: 0,
            pressElevation: 0,
          ),
        );
      }).toList(),
    );
  }

  // --- Goal Cards List ---
  Widget _buildGoalCardsList() {
    final List<Map<String, dynamic>> allGoals = [
      {
        "title": "Annual Revenue",
        "subtitle": "\$1,248K of \$2,400,000",
        "progress": 0.52,
        "progressStr": "52%",
        "status": "On Track",
        "color": const Color(0xFF10B981),
      },
      {
        "title": "New Accounts",
        "subtitle": "8 of 12 accounts",
        "progress": 0.67,
        "progressStr": "67%",
        "status": "On Track",
        "color": const Color(0xFF3B82F6),
      },
      {
        "title": "Retention Rate",
        "subtitle": "87% of 90% target",
        "progress": 0.87,
        "progressStr": "87%",
        "status": "At Risk",
        "color": const Color(0xFFF59E0B),
      },
    ];

    // Filter the items
    final List<Map<String, dynamic>> filteredGoals = allGoals.where((goal) {
      if (selectedFilter == "All") return true;
      return goal["status"] == selectedFilter;
    }).toList();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredGoals.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final goal = filteredGoals[index];
        final String title = goal["title"] as String;
        final String subtitle = goal["subtitle"] as String;
        final double progress = (goal["progress"] as num).toDouble();
        final String progressStr = goal["progressStr"] as String;
        final String status = goal["status"] as String;
        final Color goalColor = goal["color"] as Color;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Left colored border status indicator
                  Container(
                    width: 5,
                    color: goalColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: goalColor.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: goalColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 6,
                              backgroundColor: Colors.grey.shade100,
                              valueColor: AlwaysStoppedAnimation<Color>(goalColor),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              progressStr,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
