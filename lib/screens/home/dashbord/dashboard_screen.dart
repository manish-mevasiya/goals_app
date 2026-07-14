import 'package:flutter/material.dart';
import 'widgets/sales_manager_view.dart';
import 'widgets/my_view_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSalesManager = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: SafeArea(
        top: false, // Handle top layout ourselves with a custom dark top-bar
        child: Column(
          children: [
            // 1. Premium Dark Navy Top Bar
            _buildTopBar(context),

            // 2. Scrollable Body Contents
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Title and Welcome Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Color(0xFF1E293B),
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Good morning, Sagar",
                            style: TextStyle(
                              color: Colors.blueGrey.shade400,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tab Toggles (Sales Manager vs My View)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildTabToggle(),
                    ),
                    const SizedBox(height: 20),

                    // Active Tab View
                    isSalesManager
                        ? const SalesManagerView()
                        : const MyViewTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              const CircleAvatar(
                radius: 19,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sales Manager Tab Button
          GestureDetector(
            onTap: () {
              if (!isSalesManager) {
                setState(() {
                  isSalesManager = true;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSalesManager ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: isSalesManager
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                "Sales Manager",
                style: TextStyle(
                  color: isSalesManager
                      ? const Color(0xFF1E293B)
                      : Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),

          // My View Tab Button
          GestureDetector(
            onTap: () {
              if (isSalesManager) {
                setState(() {
                  isSalesManager = false;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: !isSalesManager ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: !isSalesManager
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                "My View",
                style: TextStyle(
                  color: !isSalesManager
                      ? const Color(0xFF1E293B)
                      : Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
