import 'package:flutter/material.dart';

class EditGoalsSheet extends StatefulWidget {
  const EditGoalsSheet({super.key});

  @override
  State<EditGoalsSheet> createState() => _EditGoalsSheetState();
}

class _EditGoalsSheetState extends State<EditGoalsSheet> {
  String selectedAdvisor = "Brock Wilson";

  final List<String> advisors = [
    "Brock Wilson",
    "Aya Pedrad",
    "Russ Holt",
    "Jules Richards",
    "Amanda Morrison",
    "Doug Silverness",
  ];

  @override
  Widget build(BuildContext context) {
    // Padding to push content above keyboard if visible
    final double keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0 + keyboardPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header Row (Title & Close Button)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Edit Goals — 2026",
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.grey.shade600, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 1. Advisor Selector Field
            _buildLabel("ADVISOR"),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedAdvisor,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1E293B)),
                  items: advisors.map((String advisor) {
                    return DropdownMenuItem<String>(
                      value: advisor,
                      child: Text(
                        advisor,
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedAdvisor = value;
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Annual Sales Goal & Monthly Target Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("ANNUAL SALES GOAL"),
                      const SizedBox(height: 6),
                      _buildTextField(placeholder: "e.g. \$1,955,000"),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("MONTHLY TARGET"),
                      const SizedBox(height: 6),
                      _buildTextField(placeholder: "e.g. \$163,000"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3. Call Volume & Email Volume Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("CALL VOLUME / MO"),
                      const SizedBox(height: 6),
                      _buildTextField(placeholder: "e.g. 40"),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("EMAIL VOLUME / MO"),
                      const SizedBox(height: 6),
                      _buildTextField(placeholder: "e.g. 40"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 4. New Business Goal Field
            _buildLabel("NEW BUSINESS GOAL (# ACCOUNTS)"),
            const SizedBox(height: 6),
            _buildTextField(placeholder: "e.g. 5"),
            const SizedBox(height: 16),

            // 5. Notes Field
            _buildLabel("NOTES"),
            const SizedBox(height: 6),
            _buildTextField(
              placeholder: "Any context or notes for this advisor...",
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // 6. Save Button
            ElevatedButton(
              onPressed: () {
                // Perform mock save and close
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Goals saved for $selectedAdvisor!"),
                    backgroundColor: const Color(0xFF10B981),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Save Goals",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.blueGrey.shade400,
        fontWeight: FontWeight.bold,
        fontSize: 11,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTextField({required String placeholder, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      keyboardType: maxLines == 1 ? TextInputType.number : TextInputType.multiline,
      style: const TextStyle(
        color: Color(0xFF1E293B),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF10B981), width: 1.5),
        ),
      ),
    );
  }
}
