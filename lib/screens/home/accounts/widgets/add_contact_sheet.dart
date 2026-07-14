import 'package:flutter/material.dart';

class AddContactSheet extends StatefulWidget {
  const AddContactSheet({super.key});

  @override
  State<AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameController = TextEditingController(text: "First");
  final _lastNameController = TextEditingController(text: "Last");
  final _companyController = TextEditingController();
  final _titleController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedStage = "Prospect Registered";
  String _selectedAssignee = "Brock Wilson";

  // Data lists
  final List<String> _stages = [
    "Prospect Registered",
    "Contact Made",
    "Docs Collected",
    "Active Account",
  ];
  final List<String> _assignees = [
    "Brock Wilson",
    "Russ Holt",
    "Aya Pedrad",
    "Jules Richards",
    "Amanda Morrison",
    "Doug Silverness"
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyController.dispose();
    _titleController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
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
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 40),
      child: Stack(
        children: [
          // Scrollable Form
          Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 20 + bottomInset),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Close Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Add Contact",
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

                    // First Name & Last Name Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("FIRST NAME"),
                              _buildTextField(_firstNameController, "First"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("LAST NAME"),
                              _buildTextField(_lastNameController, "Last"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Company / Account Input
                    _buildLabel("COMPANY / ACCOUNT"),
                    _buildTextField(_companyController, "e.g. Lakewood Builders Inc."),
                    const SizedBox(height: 16),

                    // Title / Role Input
                    _buildLabel("TITLE / ROLE"),
                    _buildTextField(_titleController, "e.g. CFO"),
                    const SizedBox(height: 16),

                    // Phone & Email Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRequiredLabel("PHONE"),
                              _buildTextField(
                                _phoneController,
                                "(000) 000-0000",
                                keyboardType: TextInputType.phone,
                                isRequired: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("EMAIL"),
                              _buildTextField(
                                _emailController,
                                "name@co.com",
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Stage Dropdown
                    _buildLabel("STAGE"),
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

                    // Assigned To Dropdown
                    _buildLabel("ASSIGNED TO"),
                    _buildDropdown(
                      value: _selectedAssignee,
                      items: _assignees,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedAssignee = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Notes Multiline Input
                    _buildLabel("NOTES"),
                    _buildTextField(
                      _notesController,
                      "How did we meet? Key background...",
                      maxLines: 3,
                    ),
                    const SizedBox(height: 32),

                    // Add Contact Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Show success snackbar
                            final fullName = "${_firstNameController.text} ${_lastNameController.text}";
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Contact '$fullName' Added Successfully!"),
                                backgroundColor: const Color(0xFF10B981),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981), // Mockup Green
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Add Contact",
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

  // Label with a red asterisk for required fields
  Widget _buildRequiredLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 2.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontWeight: FontWeight.bold,
            fontSize: 11,
            letterSpacing: 0.5,
          ),
          children: const [
            TextSpan(
              text: " *",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String placeholder, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isRequired = false,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
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
