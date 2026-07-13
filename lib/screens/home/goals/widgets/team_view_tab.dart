import 'package:flutter/material.dart';
import 'avatar_progress_ring.dart';

class TeamViewTab extends StatefulWidget {
  const TeamViewTab({super.key});

  @override
  State<TeamViewTab> createState() => _TeamViewTabState();
}

class _TeamViewTabState extends State<TeamViewTab> {
  String selectedFilter = "All";

  final List<String> filters = ["All", "On Track", "At Risk", "Behind"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Annual Goal Card & Team ROI side-by-side Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 11, child: _buildAnnualGoalCard()),
              const SizedBox(width: 12),
              Expanded(flex: 6, child: _buildTeamRoiCard()),
            ],
          ),
          const SizedBox(height: 20),

          // 2. Filter Pills
          _buildFilterPills(),
          const SizedBox(height: 16),

          // 3. Teammates list
          _buildTeammatesList(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // --- Annual Sales Goal Card ---
  Widget _buildAnnualGoalCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 154,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B2A4A), Color(0xFF121B2F)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ANNUAL SALES GOAL — 2026",
                style: TextStyle(
                  color: Colors.blueGrey.shade300,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "\$19.35M",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ],
          ),
          // Badges
          Row(
            children: [
              _buildBadge("\$7.95M Done", const Color(0xFF10B981)),
              const SizedBox(width: 6),
              _buildBadge("At Risk", const Color(0xFFF59E0B), isWarning: true),
            ],
          ),
          // Progress bar
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Container(
                  height: 6,
                  width: double.infinity,
                  color: Colors.blueGrey.shade900,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 41,
                        child: Container(color: const Color(0xFF10B981)),
                      ),
                      Expanded(
                        flex: 59,
                        child: Container(color: Colors.transparent),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jan",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Text(
                    "41%",
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "Dec",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color, {bool isWarning = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isWarning) ...[
            Icon(Icons.warning_amber_rounded, color: color, size: 12),
            const SizedBox(width: 3),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // --- Team ROI Card ---
  Widget _buildTeamRoiCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 154,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TEAM ROI",
                style: TextStyle(
                  color: Colors.blueGrey.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              const Text(
                "285%",
                style: TextStyle(
                  color: Color(0xFF10B981),
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              Text(
                "YTD",
                style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
              ),
            ],
          ),
          Column(
            children: [
              _buildRoiStatusRow("On Track", "4/6", const Color(0xFF10B981)),
              const SizedBox(height: 4),
              _buildRoiStatusRow("At Risk", "2/6", const Color(0xFFEF4444)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoiStatusRow(String label, String count, Color color) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
        ),
        const Spacer(),
        Text(
          count,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ],
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

  // --- Teammates List ---
  Widget _buildTeammatesList() {
    final List<Map<String, dynamic>> teammates = [
      {
        "name": "Brock Wilson",
        "role": "Senior Financial Advisor",
        "progress": 0.82,
        "progressStr": "82%",
        "goalText": "\$953K of \$1,955,000",
        "status": "On Track",
        "avatar":
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150",
        "color": const Color(0xFF10B981),
        "calls": "7",
        "winRate": "68%",
        "proposals": "14",
        "avgOpp": "\$56K",
      },
      {
        "name": "Aya Pedrad",
        "role": "Senior Advisor · 115% pace",
        "progress": 0.88,
        "progressStr": "88%",
        "goalText": "\$990K of \$1,750,000",
        "status": "On Track",
        "avatar":
            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150",
        "color": const Color(0xFF10B981),
        "hasStar": true,
        "calls": "12",
        "winRate": "72%",
        "proposals": "18",
        "avgOpp": "\$61K",
      },
      {
        "name": "Russ Holt",
        "role": "Financial Advisor · 98% pace",
        "progress": 0.74,
        "progressStr": "74%",
        "goalText": "\$844K of \$1,800,000",
        "status": "On Track",
        "avatar":
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150",
        "color": const Color(0xFF10B981),
        "calls": "10",
        "winRate": "65%",
        "proposals": "15",
        "avgOpp": "\$50K",
      },
      {
        "name": "Jules Richards",
        "role": "Advisor · 88% pace — pipeline review needed",
        "progress": 0.65,
        "progressStr": "65%",
        "goalText": "\$919K of \$2,050,000",
        "status": "At Risk",
        "avatar":
            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150",
        "color": const Color(0xFFF59E0B),
        "calls": "8",
        "winRate": "58%",
        "proposals": "10",
        "avgOpp": "\$48K",
      },
      {
        "name": "Amanda Morrison",
        "role": "Financial Advisor · 82% pace",
        "progress": 0.60,
        "progressStr": "60%",
        "goalText": "\$839K of \$2,100,000",
        "status": "At Risk",
        "initials": "AM",
        "color": const Color(0xFFF59E0B),
        "calls": "9",
        "winRate": "55%",
        "proposals": "12",
        "avgOpp": "\$45K",
      },
      {
        "name": "Doug Silverness",
        "role": "Advisor · Critically behind pace — action needed",
        "progress": 0.43,
        "progressStr": "43%",
        "goalText": "\$777K of \$2,200,000",
        "status": "Behind",
        "initials": "DS",
        "color": const Color(0xFFEF4444),
        "alert": "Ace: Schedule 1:1 this week. Critical gap to close.",
        "calls": "4",
        "winRate": "42%",
        "proposals": "6",
        "avgOpp": "\$38K",
      },
    ];

    // Filter list
    final List<Map<String, dynamic>> filteredTeammates = teammates.where((
      member,
    ) {
      if (selectedFilter == "All") return true;
      return member["status"] == selectedFilter;
    }).toList();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredTeammates.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final member = filteredTeammates[index];
        final String name = member["name"] as String;
        final String role = member["role"] as String;
        final double progress = (member["progress"] as num).toDouble();
        final String progressStr = member["progressStr"] as String;
        final String goalText = member["goalText"] as String;
        final String status = member["status"] as String;
        final Color memberColor = member["color"] as Color;
        final String? avatar = member["avatar"] as String?;
        final String? initials = member["initials"] as String?;
        final String calls = member["calls"] as String;
        final String winRate = member["winRate"] as String;
        final String proposals = member["proposals"] as String;
        final String avgOpp = member["avgOpp"] as String;
        final String? alert = member["alert"] as String?;
        final bool hasStar = member["hasStar"] == true;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Left status color indicator bar
                  Container(width: 5, color: memberColor),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Teammate Header (Avatar + Info + Progress status)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AvatarProgressRing(
                                progress: progress,
                                progressColor: memberColor,
                                avatarUrl: avatar,
                                initials: initials,
                                size: 56,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            color: Color(0xFF1E293B),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              progressStr,
                                              style: TextStyle(
                                                color: memberColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 3,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: memberColor.withValues(alpha: 0.08,),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                status,
                                                style: TextStyle(
                                                  color: memberColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            role,
                                            style: TextStyle(
                                              color: status == "On Track"
                                                  ? Colors.grey.shade500
                                                  : status == "At Risk"
                                                  ? const Color(0xFFF59E0B)
                                                  : const Color(0xFFEF4444),
                                              fontSize: 12,
                                              fontWeight: status == "On Track"
                                                  ? FontWeight.normal
                                                  : FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (hasStar) ...[
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 14,
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      goalText,
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: LinearProgressIndicator(
                                        value: progress,
                                        backgroundColor: Colors.grey.shade100,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              memberColor,
                                            ),
                                        minHeight: 4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          const SizedBox(height: 12),

                          // Activity Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildMetricCell("Calls/Mo", calls),
                              _buildMetricCell(
                                "Win Rate",
                                winRate,
                                valueColor: const Color(0xFF10B981),
                              ),
                              _buildMetricCell("Proposals", proposals),
                              _buildMetricCell("Avg Opp", avgOpp, isBold: true),
                            ],
                          ),

                          // Lag Alert Box (If present)
                          if (alert != null) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF2F2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFFEE2E2),
                                ),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFEF4444),
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: "Ace: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: alert),
                                  ],
                                ),
                              ),
                            ),
                          ],
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

  Widget _buildMetricCell(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? const Color(0xFF1E293B),
            fontWeight: isBold || valueColor != null
                ? FontWeight.bold
                : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
