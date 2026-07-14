import 'package:flutter/material.dart';
import 'widgets/people_tab_view.dart';
import 'widgets/accounts_tab_view.dart';
import 'widgets/my_accounts_view.dart';
import 'widgets/add_contact_sheet.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  bool isAllAccounts = true;
  bool isPeopleTab = true; // Secondary toggle for All Accounts
  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  void _showAddContactSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddContactSheet(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchHint = isAllAccounts ? "Search..." : "Search my accounts...";

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Premium Header (Title, Subtitle, & Add Button)
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Accounts",
                        style: TextStyle(
                          color: Color(0xFF1E293B),
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "People & organizations",
                        style: TextStyle(
                          color: Colors.blueGrey.shade400,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  // Add Button
                  ElevatedButton.icon(
                    onPressed: _showAddContactSheet,
                    icon: const Icon(Icons.add, color: Colors.white, size: 18),
                    label: const Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981), // Mockup Green
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),

            // 2. Primary Tabs (All Accounts vs My Accounts)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildPrimaryTabToggle(),
              ),
            ),
            const SizedBox(height: 12),

            // 3. Secondary Category Toggles (People vs Accounts) - Only for All Accounts
            if (isAllAccounts) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildSecondaryTabToggle(),
              ),
              const SizedBox(height: 12),
            ],

            // 4. Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      searchQuery = val;
                    });
                  },
                  style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                    hintText: searchHint,
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    suffixIcon: searchQuery.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() {
                                searchQuery = "";
                              });
                            },
                            child: const Icon(Icons.clear, color: Color(0xFF94A3B8), size: 18),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 5. Scrollable Tab Contents
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: isAllAccounts
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: isPeopleTab
                            ? PeopleTabView(searchQuery: searchQuery)
                            : AccountsTabView(searchQuery: searchQuery),
                      )
                    : MyAccountsView(searchQuery: searchQuery),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryTabToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // All Accounts Tab
          GestureDetector(
            onTap: () {
              if (!isAllAccounts) {
                setState(() {
                  isAllAccounts = true;
                  searchQuery = "";
                  _searchController.clear();
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isAllAccounts ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: isAllAccounts
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : [],
              ),
              child: Text(
                "All Accounts",
                style: TextStyle(
                  color: isAllAccounts ? const Color(0xFF1E293B) : Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),

          // My Accounts Tab
          GestureDetector(
            onTap: () {
              if (isAllAccounts) {
                setState(() {
                  isAllAccounts = false;
                  searchQuery = "";
                  _searchController.clear();
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: !isAllAccounts ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: !isAllAccounts
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : [],
              ),
              child: Text(
                "My Accounts",
                style: TextStyle(
                  color: !isAllAccounts ? const Color(0xFF1E293B) : Colors.grey.shade600,
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

  Widget _buildSecondaryTabToggle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // People Sub-tab
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!isPeopleTab) {
                  setState(() {
                    isPeopleTab = true;
                    searchQuery = "";
                    _searchController.clear();
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isPeopleTab ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isPeopleTab
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : [],
                ),
                child: Text(
                  "People",
                  style: TextStyle(
                    color: isPeopleTab ? const Color(0xFF1E293B) : Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),

          // Accounts Sub-tab
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (isPeopleTab) {
                  setState(() {
                    isPeopleTab = false;
                    searchQuery = "";
                    _searchController.clear();
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !isPeopleTab ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: !isPeopleTab
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : [],
                ),
                child: Text(
                  "Accounts",
                  style: TextStyle(
                    color: !isPeopleTab ? const Color(0xFF1E293B) : Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
