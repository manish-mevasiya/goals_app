import 'package:flutter/material.dart';

class TeamPipelineView extends StatefulWidget {
  const TeamPipelineView({super.key});

  @override
  State<TeamPipelineView> createState() => _TeamPipelineViewState();
}

class _TeamPipelineViewState extends State<TeamPipelineView> {
  final List<String> _stages = ["Prospect", "Contact Made", "Docs", "Payment", "Enrolled"];
  String _selectedStage = "Enrolled"; // Match the mockup's selected stage (Enrolled is green indicator)

  // Stage counts for badges
  final Map<String, int> _stageCounts = {
    "Prospect": 2,
    "Contact Made": 3,
    "Docs": 2,
    "Payment": 2,
    "Enrolled": 3,
  };

  // Teammates & deals data matching the mockup
  final List<Map<String, dynamic>> _allDeals = [
    // Prospect Deals
    {
      "title": "Clearview Dental — Employee Plan",
      "company": "Clearview Dental Associates",
      "stage": "Prospect",
      "contactName": "Sara Kim",
      "contactInitials": "SK",
      "ownerInitials": "RH",
      "ownerColor": const Color(0xFF8B5CF6), // Purple (Russ Holt)
      "value": "\$70,000",
      "age": "1d",
      "dotColor": const Color(0xFFCBD5E1), // light grey
    },
    {
      "title": "Summit Credit Union",
      "company": "Summit Credit Union",
      "stage": "Prospect",
      "contactName": "Aya Pedrad",
      "contactInitials": "AP",
      "ownerInitials": "BW",
      "ownerColor": const Color(0xFF10B981), // Green (Brock Wilson)
      "value": "\$95,000",
      "age": "12d",
      "dotColor": const Color(0xFFCBD5E1), // light grey
    },
    // Contact Made Deals
    {
      "title": "Riverside Financial — Group Benefits",
      "company": "Riverside Financial Group",
      "stage": "Contact Made",
      "contactName": "Marcus Lee",
      "contactInitials": "ML",
      "ownerInitials": "BW",
      "ownerColor": const Color(0xFF10B981), // Green (Brock Wilson)
      "value": "\$92,000",
      "age": "3d",
      "dotColor": const Color(0xFF10B981), // Green
    },
    {
      "title": "Clearview Dental — Employee Plan",
      "company": "Clearview Dental Associates",
      "stage": "Contact Made",
      "contactName": "Sara Kim",
      "contactInitials": "SK",
      "ownerInitials": "RH",
      "ownerColor": const Color(0xFF8B5CF6), // Purple (Russ Holt)
      "value": "\$78,000",
      "age": "7d",
      "dotColor": const Color(0xFF10B981), // Green
    },
    {
      "title": "Apex Consulting Group",
      "company": "Apex Consulting",
      "stage": "Contact Made",
      "contactName": "Jules Richards",
      "contactInitials": "JR",
      "ownerInitials": "AM",
      "ownerColor": const Color(0xFFF59E0B), // Orange (Amanda Morrison)
      "value": "\$45,000",
      "age": "4d",
      "dotColor": const Color(0xFF10B981), // Green
    },
    // Docs Deals
    {
      "title": "Metro Schools — Staff Benefits",
      "company": "Metro Schools",
      "stage": "Docs",
      "contactName": "Russ Holt",
      "contactInitials": "RH",
      "ownerInitials": "AP",
      "ownerColor": const Color(0xFF3B82F6), // Blue (Aya Pedrad)
      "value": "\$115,000",
      "age": "2d",
      "dotColor": const Color(0xFFF59E0B), // Orange
    },
    {
      "title": "Westside Hospital — Group Plan",
      "company": "Westside Hospital",
      "stage": "Docs",
      "contactName": "Doug Silverness",
      "contactInitials": "DS",
      "ownerInitials": "JR",
      "ownerColor": const Color(0xFFEF4444), // Red (Jules Richards)
      "value": "\$130,000",
      "age": "5d",
      "dotColor": const Color(0xFFF59E0B), // Orange
    },
    // Payment Deals
    {
      "title": "Northview Law Group",
      "company": "Northview Law",
      "stage": "Payment",
      "contactName": "Amanda Morrison",
      "contactInitials": "AM",
      "ownerInitials": "DS",
      "ownerColor": const Color(0xFF64748B), // Slate (Doug Silverness)
      "value": "\$60,000",
      "age": "1d",
      "dotColor": const Color(0xFFEF4444), // Red
    },
    {
      "title": "Eastside Tech — Employee Insurance",
      "company": "Eastside Tech Inc.",
      "stage": "Payment",
      "contactName": "Jane Doe",
      "contactInitials": "JD",
      "ownerInitials": "RH",
      "ownerColor": const Color(0xFF8B5CF6), // Purple (Russ Holt)
      "value": "\$85,000",
      "age": "6d",
      "dotColor": const Color(0xFFEF4444), // Red
    },
    // Enrolled Deals
    {
      "title": "Riverside Financial — Group Benefits",
      "company": "Riverside Financial Group",
      "stage": "Enrolled",
      "contactName": "Marcus Lee",
      "contactInitials": "ML",
      "ownerInitials": "BW",
      "ownerColor": const Color(0xFF10B981), // Green (Brock Wilson)
      "value": "\$92,000",
      "age": "3d",
      "dotColor": const Color(0xFF10B981), // Green
    },
    {
      "title": "Clearview Dental — Employee Plan",
      "company": "Clearview Dental Associates",
      "stage": "Enrolled",
      "contactName": "Sara Kim",
      "contactInitials": "SK",
      "ownerInitials": "RH",
      "ownerColor": const Color(0xFF8B5CF6), // Purple (Russ Holt)
      "value": "\$70,000",
      "age": "1d",
      "dotColor": const Color(0xFFCBD5E1), // light grey dot
    },
    {
      "title": "Tri-State Logistics Group",
      "company": "Tri-State Logistics",
      "stage": "Enrolled",
      "contactName": "John Smith",
      "contactInitials": "JS",
      "ownerInitials": "AP",
      "ownerColor": const Color(0xFF3B82F6), // Blue (Aya Pedrad)
      "value": "\$105,000",
      "age": "8d",
      "dotColor": const Color(0xFF10B981), // Green
    },
  ];

  final ScrollController _stageScrollController = ScrollController();

  void _scrollStages(bool forward) {
    double offset = _stageScrollController.offset;
    double max = _stageScrollController.position.maxScrollExtent;
    double target = forward ? offset + 120 : offset - 120;
    _stageScrollController.animateTo(
      target.clamp(0.0, max),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _navigateStage(bool forward) {
    int index = _stages.indexOf(_selectedStage);
    if (forward && index < _stages.length - 1) {
      setState(() {
        _selectedStage = _stages[index + 1];
      });
    } else if (!forward && index > 0) {
      setState(() {
        _selectedStage = _stages[index - 1];
      });
    }
  }

  @override
  void dispose() {
    _stageScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter deals matching current selected stage
    final List<Map<String, dynamic>> filteredDeals = _allDeals
        .where((deal) => deal["stage"] == _selectedStage)
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. KPI Cards Grid
          Row(
            children: [
              Expanded(
                child: _buildKpiCard("TOTAL VALUE", "\$1.29M"),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildKpiCard("OPPS", "12"),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildKpiCard("AVG SIZE", "\$108K"),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildKpiCard(
                  "WIN RATE",
                  "58%",
                  valueColor: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 2. Horizontal Pipeline Stage Selector with Arrows & Indicator
          _buildStageSelectorBar(),
          const SizedBox(height: 20),

          // 3. Deals List
          ListView.separated(
            shrinkWrap: true,
            padding: .zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredDeals.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemBuilder: (context, index) {
              final deal = filteredDeals[index];
              final Color dotColor = deal["dotColor"] as Color;
              final Color ownerColor = deal["ownerColor"] as Color;

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stage dot + Title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: dotColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deal["title"] as String,
                                style: const TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                deal["company"] as String,
                                style: TextStyle(
                                  color: Colors.blueGrey.shade300,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Client (Left) vs Owner (Right)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left: Client contact
                        Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE2E8F0),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                deal["contactInitials"] as String,
                                style: const TextStyle(
                                  color: Color(0xFF64748B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              deal["contactName"] as String,
                              style: TextStyle(
                                color: Colors.blueGrey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        // Right: Owner initials badge + Value + Age
                        Row(
                          children: [
                            // Owner initials badge
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: ownerColor,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                deal["ownerInitials"] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              deal["value"] as String,
                              style: const TextStyle(
                                color: Color(0xFF10B981), // mockup green
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              deal["age"] as String,
                              style: TextStyle(
                                color: Colors.blueGrey.shade300,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildStageSelectorBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Left navigation arrow
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _scrollStages(false),
                icon: const Icon(Icons.arrow_left, color: Color(0xFF94A3B8), size: 28),
              ),

              // Stages Horizontal List view
              Expanded(
                child: SizedBox(
                  height: 38,
                  child: ListView.builder(
                    controller: _stageScrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _stages.length,
                    itemBuilder: (context, index) {
                      final stage = _stages[index];
                      final isSelected = stage == _selectedStage;
                      final count = _stageCounts[stage] ?? 0;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedStage = stage;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Text(
                                stage,
                                style: TextStyle(
                                  color: isSelected ? const Color(0xFF1E293B) : Colors.grey.shade400,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF10B981) : const Color(0xFFE2E8F0),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  count.toString(),
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.grey.shade600,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Right navigation arrow
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _scrollStages(true),
                icon: const Icon(Icons.arrow_right, color: Color(0xFF94A3B8), size: 28),
              ),

              // Vertically stacked Up/Down toggle arrows on the right
              Container(
                height: 38,
                width: 24,
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _navigateStage(false),
                      child: const Icon(Icons.arrow_drop_up, size: 16, color: Color(0xFF64748B)),
                    ),
                    GestureDetector(
                      onTap: () => _navigateStage(true),
                      child: const Icon(Icons.arrow_drop_down, size: 16, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Scroll track indicator line with custom centered handle
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 3,
                  width: double.infinity,
                  color: const Color(0xFFE2E8F0),
                ),
                Container(
                  height: 4,
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard(String label, String value, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
