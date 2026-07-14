import 'package:flutter/material.dart';

class AddOpportunitySheet extends StatefulWidget {
  const AddOpportunitySheet({super.key});

  @override
  State<AddOpportunitySheet> createState() => _AddOpportunitySheetState();
}

class _AddOpportunitySheetState extends State<AddOpportunitySheet> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController(text: "Testing");
  final _companyController = TextEditingController(text: "Testing");
  final _contactController = TextEditingController(text: "9384778384");
  final _valueController = TextEditingController(text: "10");
  final _notesController = TextEditingController(text: "testing");

  DateTime _selectedDate = DateTime(2026, 7, 13);
  String _selectedStage = "Contact Made";
  String _selectedOwner = "Russ Holt";
  String _selectedPipeline = "Renewals";

  // Data lists
  final List<String> _stages = ["Prospect", "Contact Made", "Docs", "Payment", "Enrolled"];
  final List<String> _owners = [
    "Russ Holt",
    "Brock Wilson",
    "Aya Pedrad",
    "Jules Richards",
    "Amanda Morrison",
    "Doug Silverness"
  ];
  final List<String> _pipelines = ["Renewals", "New Business"];

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _contactController.dispose();
    _valueController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF10B981), // Mockup Green
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return "${date.day}-${months[date.month - 1]}-${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    // Keyboard inset padding
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
      child: Stack(
        children: [
          // Scrollable Content
          Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 20 + bottomInset),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle and Title row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Add Opportunity",
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
                              color: const Color(0xFFF1F5F9),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Opportunity Name Input
                    _buildLabel("OPPORTUNITY NAME"),
                    _buildTextField(_nameController, "Enter opportunity name"),
                    const SizedBox(height: 16),

                    // Company Input
                    _buildLabel("COMPANY / ORGANIZATION"),
                    _buildTextField(_companyController, "Enter company name"),
                    const SizedBox(height: 16),

                    // Primary Contact Input
                    _buildLabel("PRIMARY CONTACT"),
                    _buildTextField(_contactController, "Enter contact details", keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),

                    // Value and Expected Close Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("DEAL VALUE"),
                              _buildTextField(
                                _valueController,
                                "Value",
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("EXPECTED CLOSE"),
                              GestureDetector(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  height: 48,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: const Color(0xFFCBD5E1)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatDate(_selectedDate),
                                        style: const TextStyle(
                                          color: Color(0xFF1E293B),
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 16,
                                        color: Color(0xFF64748B),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Pipeline Stage Dropdown
                    _buildLabel("PIPELINE STAGE"),
                    _buildDropdown(
                      value: _selectedStage,
                      items: _stages,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedStage = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Owner and Pipeline Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("OWNER"),
                              _buildDropdown(
                                value: _selectedOwner,
                                items: _owners,
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _selectedOwner = val;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("PIPELINE"),
                              _buildDropdown(
                                value: _selectedPipeline,
                                items: _pipelines,
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _selectedPipeline = val;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Notes Input
                    _buildLabel("NOTES"),
                    _buildTextField(_notesController, "Enter additional details...", maxLines: 3),
                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Show success indicator and close
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Opportunity '${_nameController.text}' Added!"),
                                backgroundColor: const Color(0xFF10B981),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Add Opportunity",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 2.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF64748B),
          fontWeight: FontWeight.bold,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String placeholder, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(
        color: Color(0xFF1E293B),
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF10B981), width: 1.5),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "This field is required";
        }
        return null;
      },
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
          isExpanded: true,
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 14,
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
        ),
      ),
    );
  }
}
