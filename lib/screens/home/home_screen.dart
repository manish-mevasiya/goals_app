import 'package:flutter/material.dart';
import 'package:goals_app/utils/theme/app_colors.dart';
import 'package:goals_app/screens/home/dashbord/dashboard_screen.dart';
import 'package:goals_app/screens/home/goals/goals_screen.dart';

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
    const Center(child: Text("Pipeline")),
    const Center(child: Text("Accounts")),
    const Center(child: Text("More")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: pages[currentIndex],
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
