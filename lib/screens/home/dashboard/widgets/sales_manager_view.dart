import 'package:flutter/material.dart';
import 'custom_sparkline.dart';

class SalesManagerView extends StatefulWidget {
  const SalesManagerView({super.key});

  @override
  State<SalesManagerView> createState() => _SalesManagerViewState();
}

class _SalesManagerViewState extends State<SalesManagerView> {
  String selectedPeriod = "Last 7 Days";

  final List<String> periods = [
    "Last 7 Days",
    "This Month",
    "Last 90 Days",
    "YTD",
    "Annual",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Annual Sales Goal Card
          _buildAnnualSalesGoalCard(),
          const SizedBox(height: 16),

          // 2. Total Sales YTD Card
          _buildTotalSalesYtdCard(),
          const SizedBox(height: 20),

          // 3. Horizontal Period Selector Pills
          _buildPeriodSelector(),
          const SizedBox(height: 16),

          // 4. Grid of Stat Cards
          _buildStatsGrid(),
          const SizedBox(height: 16),

          // 5. Team ROI Card
          _buildTeamRoiCard(),
          const SizedBox(height: 16),

          // 6. Leaderboard Card
          _buildLeaderboardCard(),
          const SizedBox(height: 16),

          // 7. Top Performers Card
          _buildTopPerformersCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // --- Annual Sales Goal Card ---
  Widget _buildAnnualSalesGoalCard() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ANNUAL SALES GOAL",
                    style: TextStyle(
                      color: Colors.blueGrey.shade300,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "\$19,355,000",
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "41%",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  Text(
                    "of Annual",
                    style: TextStyle(
                      color: Colors.blueGrey.shade300,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Badges Row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildBadge("\$7.95M Achieved", const Color(0xFF10B981)),
              _buildBadge("\$11.4M Remaining", const Color(0xFFEF4444)),
              _buildBadge("At Risk", const Color(0xFFF59E0B), isWarning: true),
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jan 2026",
                style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11),
              ),
              Text(
                "H2 Starts July",
                style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11),
              ),
              Text(
                "Dec 2026",
                style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color, {bool isWarning = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isWarning) ...[
            Icon(Icons.warning_amber_rounded, color: color, size: 14),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // --- Total Sales YTD Card ---
  Widget _buildTotalSalesYtdCard() {
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
            "Total Sales YTD",
            style: TextStyle(
              color: Colors.blueGrey.shade300,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "\$7,955,967",
            style: TextStyle(
              color: Color(0xFF10B981),
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: CustomSparkline(
              data: const [1.0, 1.5, 2.8, 3.9, 5.5, 7.95],
              labels: const ["Jan", "Mar", "May", "Jul", "Sep", "Nov"],
              lineColor: const Color(0xFF10B981),
              fillColors: const [Color(0x3310B981), Color(0x0010B981)],
            ),
          ),
        ],
      ),
    );
  }

  // --- Period Selector Pills ---
  Widget _buildPeriodSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: periods.map((period) {
          bool isSelected = selectedPeriod == period;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              showCheckmark: false,
              label: Text(period),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    selectedPeriod = period;
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
      ),
    );
  }

  // --- Grid of Stat Cards ---
  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: .zero,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.7,
      children: [
        _buildStatCard("LEADS", "142", "18 this week", isUp: true),
        _buildStatCard("OPPORTUNITIES", "67", "9 this week", isUp: true),
        _buildStatCard("PROPOSALS", "34", "same as last week", isUp: null),
        _buildStatCard("CLOSED / WON", "19", "3 this week", isUp: true),
        _buildStatCard("AVG DEAL SIZE", "\$82,900", "\$4.2K MoM", isUp: true),
        _buildStatCard("WIN RATE", "58%", "6pp vs Q2 2025", isUp: true),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subText, {
    bool? isUp,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.blueGrey.shade400,
              fontWeight: FontWeight.bold,
              fontSize: 11,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Row(
            children: [
              if (isUp == true) ...[
                const Icon(
                  Icons.arrow_drop_up,
                  color: Color(0xFF10B981),
                  size: 18,
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    subText,
                    style: const TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ] else if (isUp == false) ...[
                const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFFEF4444),
                  size: 18,
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    subText,
                    style: const TextStyle(
                      color: Color(0xFFEF4444),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ] else ...[
                const Text(
                  "— ",
                  style: TextStyle(
                    color: Color(0xFFF59E0B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    subText,
                    style: const TextStyle(
                      color: Color(0xFFF59E0B),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // --- Team ROI Card ---
  Widget _buildTeamRoiCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TEAM ROI",
                    style: TextStyle(
                      color: Colors.blueGrey.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "312%",
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.arrow_drop_up, color: Colors.grey, size: 16),
                      Text(
                        "4pts vs last period",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  _buildRoiBadge("On Track", "4/6", const Color(0xFF10B981)),
                  const SizedBox(width: 8),
                  _buildRoiBadge("At Risk", "2/6", const Color(0xFFEF4444)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Custom segmented indicator bar: 6 segments
          Row(
            children: List.generate(6, (index) {
              // 0, 2, 4 are light green; 1, 3, 5 are solid green
              bool isSolid = index % 2 != 0;
              return Expanded(
                child: Container(
                  height: 14,
                  margin: EdgeInsets.only(right: index == 5 ? 0 : 6),
                  decoration: BoxDecoration(
                    color: isSolid
                        ? const Color(0xFF10B981)
                        : const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRoiBadge(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- Leaderboard Card ---
  Widget _buildLeaderboardCard() {
    final List<Map<String, dynamic>> players = [
      {
        "rank": 1,
        "name": "Aya Pedrad",
        "role": "Sr. Advisor",
        "amount": "\$990,086",
        "progress": 0.95,
        "avatar":
            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150",
      },
      {
        "rank": 2,
        "name": "Elena Vasquez",
        "role": "Advisor",
        "amount": "\$972,775",
        "progress": 0.85,
        "avatar":
            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150",
      },
      {
        "rank": 3,
        "name": "Marcus Bradley",
        "role": "Advisor",
        "amount": "\$967,500",
        "progress": 0.8,
        "avatar":
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150",
      },
      {
        "rank": 4,
        "name": "Brock Wilson",
        "role": "Sr. Advisor",
        "amount": "\$953,412",
        "progress": 0.72,
        "avatar":
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150",
      },
      {
        "rank": 5,
        "name": "Jules Richards",
        "role": "Advisor",
        "amount": "\$919,456",
        "progress": 0.65,
        "avatar":
            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150",
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Leaderboard",
                style: TextStyle(
                  color: Color(0xFF1E293B),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                ),
                child: const Row(
                  children: [
                    Text(
                      "Full team",
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      color: Color(0xFF10B981),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            padding: .zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: players.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final player = players[index];
              Color rankColor = Colors.grey.shade400;
              if (player["rank"] == 1) rankColor = Colors.amber.shade700;
              if (player["rank"] == 2) rankColor = Colors.blueGrey.shade400;
              if (player["rank"] == 3) rankColor = Colors.brown.shade400;

              return Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: rankColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${player["rank"]}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(player["avatar"]),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player["name"],
                          style: const TextStyle(
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          player["role"],
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Mini progress bar under the name
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: player["progress"],
                            backgroundColor: Colors.grey.shade100,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF10B981),
                            ),
                            minHeight: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    player["amount"],
                    style: const TextStyle(
                      color: Color(0xFF0057A8),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // --- Top Performers Card ---
  Widget _buildTopPerformersCard() {
    final List<Map<String, dynamic>> performers = [
      {
        "name": "Aya Pedrad",
        "role": "Sr. Advisor",
        "amount": "\$990K",
        "progress": 0.95,
        "avatar":
            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150",
      },
      {
        "name": "Elena Vasquez",
        "role": "Advisor",
        "amount": "\$973K",
        "progress": 0.85,
        "avatar":
            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150",
      },
      {
        "name": "Marcus Bradley",
        "role": "Advisor",
        "amount": "\$968K",
        "progress": 0.8,
        "avatar":
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150",
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Top Performers",
                style: TextStyle(
                  color: Color(0xFF1E293B),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                ),
                child: const Row(
                  children: [
                    Text(
                      "All",
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      color: Color(0xFF10B981),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            padding: .zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: performers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final perf = performers[index];

              return Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(perf["avatar"]),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          perf["name"],
                          style: const TextStyle(
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          perf["role"],
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: perf["progress"],
                            backgroundColor: Colors.grey.shade100,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF10B981),
                            ),
                            minHeight: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    perf["amount"],
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
