import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/location_provider.dart';
import '../providers/service_provider.dart';
import '../providers/worker_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/worker_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LocationProvider>(context, listen: false)
          .getCurrentLocation();
      Provider.of<WorkerProvider>(context, listen: false).fetchWorkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final workerProvider = Provider.of<WorkerProvider>(context);
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'EmPoverty',
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          authProvider.logout();
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout, color: AppColors.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppDimensions.radiusLarge),
                  bottomRight: Radius.circular(AppDimensions.radiusLarge),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authProvider.isLoggedIn
                          ? 'Welcome, ${authProvider.currentUser?.name ?? 'User'}!'
                          : 'Find Trusted Services',
                      style: AppTypography.heading2.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Discover skilled workers and local businesses near you',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    if (locationProvider.latitude != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingMedium,
                          vertical: AppDimensions.paddingSmall,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMedium,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                locationProvider.address ??
                                    'Location Selected',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            // Service Filter
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter by Service',
                    style: AppTypography.subtitle1,
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          label: const Text('All Services'),
                          selected: _selectedService == null,
                          onSelected: (selected) {
                            setState(() {
                              _selectedService = null;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ...serviceProvider.services
                            .map((service) => Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(service.name),
                                    selected: _selectedService == service.name,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedService = selected
                                            ? service.name
                                            : null;
                                      });
                                    },
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            // Workers List
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
              ),
              child: Text(
                'Service Providers',
                style: AppTypography.subtitle1,
              ),
            ),
            const SizedBox(height: 12),
            if (workerProvider.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (workerProvider.workers.isEmpty)
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Center(
                  child: Text(
                    'No service providers found',
                    style: AppTypography.bodyMedium,
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: workerProvider.workers.length,
                itemBuilder: (context, index) {
                  final worker = workerProvider.workers[index];

                  if (_selectedService != null &&
                      worker.category != _selectedService) {
                    return const SizedBox.shrink();
                  }

                  return WorkerCard(
                    worker: worker,
                    onTap: () {
                      workerProvider.selectWorker(worker);
                      Navigator.of(context)
                          .pushNamed('/service-provider-details');
                    },
                    onCallTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Calling ${worker.name}...'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                },
              ),
            const SizedBox(height: AppDimensions.paddingLarge),
          ],
        ),
      ),
    );
  }
}
