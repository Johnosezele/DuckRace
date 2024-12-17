import 'package:duckrace/core/constants/assets_images.dart';
import 'package:duckrace/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';

class RegisterSponsorFormScreen extends StatefulWidget {
  const RegisterSponsorFormScreen({super.key});

  @override
  State<RegisterSponsorFormScreen> createState() => _RegisterSponsorFormScreenState();
}

class _RegisterSponsorFormScreenState extends State<RegisterSponsorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _logoPath;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _websiteController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _websiteController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Handle form submission
      context.push('/sponsor/showcase');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Register as Sponsor',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 24),
                Stack(
                  children: [
                    Image.asset(
                      Images.backgroundImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    SizedBox(
                      child: _buildSection(
                        'Public Information',
                        'This information will be displayed publicly once approved by the operator.',
                        [
                          _buildLogoUpload(),
                          _buildTextField(
                            label: 'Enter Your Sponsor\'s Name',
                            hint: 'Enter Your Organization\'s Name',
                            controller: _nameController,
                          ),
                          _buildTextField(
                            label: 'Describe Your Organization',
                            hint: 'Provide a brief overview of your organization\'s mission, goals, and values (Max: 300 words)',
                            controller: _descriptionController,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildSection(
                  'Internal Information',
                  'This information will only be visible to the operator and is required for verification.',
                  [
                    _buildTextField(
                      label: 'Sponsor Website',
                      hint: 'Sponsor website URL',
                      controller: _websiteController,
                    ),
                    _buildTextField(
                      label: 'Contact Email',
                      hint: 'Official Contact Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildTextField(
                      label: 'Phone Number',
                      hint: 'Contact Phone Number',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Submit Registration',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.pop(),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String description, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildLogoUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Logo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Recommended size: 200x200',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: _logoPath != null
                  ? Image.asset(_logoPath!, fit: BoxFit.cover)
                  : const Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement logo upload
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text(
                'Upload',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
