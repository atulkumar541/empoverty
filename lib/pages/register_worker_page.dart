import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../models/worker_model.dart';
import '../providers/auth_provider.dart';
import '../providers/location_provider.dart';
import '../providers/service_provider.dart';
import '../providers/worker_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class RegisterWorkerPage extends StatefulWidget {
  const RegisterWorkerPage({Key? key}) : super(key: key);

  @override
  State<RegisterWorkerPage> createState() => _RegisterWorkerPageState();
}

class _RegisterWorkerPageState extends State<RegisterWorkerPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  String? _selectedCategory;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Register as Service Provider',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Personal Info Section
                Text(
                  'Personal Information',
                  style: AppTypography.heading3,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                CustomTextField(
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  controller: _nameController,
                  prefixIcon: const Icon(Icons.person),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                CustomTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                CustomTextField(
                  label: 'Phone Number',
                  hintText: 'Enter your phone number',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.paddingLarge),
                // Service Category Section
                Text(
                  'Service Category',
                  style: AppTypography.heading3,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Select your service category',
                    prefixIcon: const Icon(Icons.category),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                  ),
                  items: serviceProvider.services
                      .map((service) =>
                          DropdownMenuItem(
                            value: service.name,
                            child: Text(service.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a service category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.paddingLarge),
                // Bio Section
                Text(
                  'Professional Bio',
                  style: AppTypography.heading3,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                CustomTextField(
                  label: 'Bio',
                  hintText: 'Tell us about your experience...',
                  controller: _bioController,
                  maxLines: 3,
                  minLines: 3,
                ),
                const SizedBox(height: AppDimensions.paddingLarge),
                // Location Section
                Text(
                  'Location',
                  style: AppTypography.heading3,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                if (locationProvider.latitude != null)
                  Container(
                    padding:
                        const EdgeInsets.all(AppDimensions.paddingMedium),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: AppColors.success),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location Selected',
                                style: AppTypography.subtitle2,
                              ),
                              Text(
                                locationProvider.address ??
                                    '${locationProvider.latitude}, ${locationProvider.longitude}',
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  CustomButton(
                    label: 'Pick Location',
                    onPressed: () async {
                      await locationProvider.getCurrentLocation();
                    },
                    icon: const Icon(Icons.location_on),
                  ),
                const SizedBox(height: AppDimensions.paddingLarge),
                // Register Button
                CustomButton(
                  label: authProvider.isLoading ? 'Registering...' : 'Register',
                  onPressed: _selectedCategory == null
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _handleRegister(context, authProvider);
                          }
                        },
                  isLoading: authProvider.isLoading,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final workerProvider = Provider.of<WorkerProvider>(context, listen: false);
    
    await authProvider.registerUser(
      _nameController.text,
      _emailController.text,
      _phoneController.text,
      UserType.serviceProvider,
      address: locationProvider.address,
      latitude: locationProvider.latitude,
      longitude: locationProvider.longitude,
    );

    if (authProvider.isLoggedIn) {
      // Create and add worker to WorkerProvider
      final newWorker = Worker(
        userId: authProvider.currentUser?.email ?? '',
        name: _nameController.text,
        phone: _phoneController.text,
        category: _selectedCategory ?? '',
        bio: _bioController.text.isNotEmpty ? _bioController.text : null,
        skills: [],
        address: locationProvider.address,
        latitude: locationProvider.latitude,
        longitude: locationProvider.longitude,
        rating: 0.0,
        reviewCount: 0,
        isVerified: false,
      );
      
      await workerProvider.createWorker(newWorker);
      
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
