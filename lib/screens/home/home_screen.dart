import 'package:flutter/material.dart';
import 'package:goals_app/utils/theme/app_colors.dart';
import 'package:goals_app/screens/home/dashboard/dashboard_screen.dart';
import 'package:goals_app/screens/home/goals/goals_screen.dart';
import 'package:goals_app/screens/home/pipeline/pipeline_screen.dart';
import 'package:goals_app/screens/home/accounts/accounts_screen.dart';
import 'package:goals_app/screens/home/more/more_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const DashboardScreen(),
    const GoalsScreen(),
    const PipelineScreen(),
    const AccountsScreen(),
    const MoreScreen(),
  ];

  Widget _buildTopBar(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.fromLTRB(16, statusBarHeight + 10, 16, 14),
      decoration: const BoxDecoration(
        color: Color(0xFF1B2A4A), // Premium Dark Navy
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Stylized white 'g' logo
          const Row(
            children: [
              Text(
                "g",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'serif',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),

          // Right: Action buttons (Search, Notification Bell with red badge, Profile Avatar)
          Row(
            children: [
              // Search Icon
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white, size: 20),
                  onPressed: () {},
                  constraints: const BoxConstraints(
                    minWidth: 38,
                    minHeight: 38,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(width: 10),

              // Notification Bell
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {},
                      constraints: const BoxConstraints(
                        minWidth: 38,
                        minHeight: 38,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),

              // Profile Avatar
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: Column(
        children: [
          _buildTopBar(context),
          Expanded(
            child: pages[currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(
              icon: Icons.dashboard_outlined,
              activeIcon: Icons.dashboard,
              label: "Dashboard",
              index: 0,
            ),

            _navItem(
              icon: Icons.track_changes_outlined,
              activeIcon: Icons.track_changes,
              label: "Goals",
              index: 1,
            ),

            _navItem(
              icon: Icons.bar_chart_outlined,
              activeIcon: Icons.bar_chart,
              label: "Pipeline",
              index: 2,
            ),

            _navItem(
              icon: Icons.people_outline,
              activeIcon: Icons.people,
              label: "Accounts",
              index: 3,
            ),

            _moreItem(),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    bool selected = currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? activeIcon : icon,
              color: selected ? AppColors.primaryColor : Colors.grey,
              size: 28,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? AppColors.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moreItem() {
    bool selected = currentIndex == 4;

    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = 4;
        });
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.more_vert,
                  color: selected ? AppColors.primaryColor : Colors.grey,
                  size: 28,
                ),

                Positioned(
                  right: -3,
                  top: -5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "6",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              "More",
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? AppColors.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
