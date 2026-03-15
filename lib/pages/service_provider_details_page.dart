import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/worker_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/rating_widget.dart';

class ServiceProviderDetailsPage extends StatelessWidget {
  const ServiceProviderDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workerProvider = Provider.of<WorkerProvider>(context);
    final worker = workerProvider.selectedWorker;

    if (worker == null) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Service Provider',
          onBackPressed: () => Navigator.of(context).pop(),
        ),
        body: const Center(
          child: Text('No service provider selected'),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: worker.name,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Container(
              width: double.infinity,
              height: 250,
              color: AppColors.lightGrey,
              child: worker.profileImageUrl != null
                  ? Image.network(
                      worker.profileImageUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.person,
                      size: 100,
                      color: AppColors.grey,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Verification
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              worker.name,
                              style: AppTypography.heading2,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              worker.category,
                              style: AppTypography.subtitle1,
                            ),
                          ],
                        ),
                      ),
                      if (worker.isVerified)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMedium,
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.verified,
                                color: AppColors.success,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Verified',
                                style: TextStyle(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Rating
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingWidget(
                              rating: worker.rating,
                              reviewCount: worker.reviewCount,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Customer Rating',
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              worker.reviewCount.toString(),
                              style: AppTypography.heading2,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Reviews',
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),
                  // Bio
                  if (worker.bio != null) ...[
                    Text(
                      'About',
                      style: AppTypography.subtitle1,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      worker.bio!,
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                  ],
                  // Skills
                  if (worker.skills.isNotEmpty) ...[
                    Text(
                      'Skills & Expertise',
                      style: AppTypography.subtitle1,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: worker.skills
                          .map((skill) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusMedium,
                                  ),
                                ),
                                child: Text(
                                  skill,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                  ],
                  // Certificates
                  if (worker.certificateUrls.isNotEmpty) ...[
                    Text(
                      'Certifications',
                      style: AppTypography.subtitle1,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: worker.certificateUrls.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMedium,
                              ),
                            ),
                            child: Image.network(
                              worker.certificateUrls[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                  ],
                  // Location
                  if (worker.address != null) ...[
                    Text(
                      'Location',
                      style: AppTypography.subtitle1,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusMedium,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              worker.address!,
                              style: AppTypography.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                  ],
                  // Action Buttons
                  CustomButton(
                    label: 'Call to inquire',
                    onPressed: () async {
                      // print phone number is available
                      //print worker details to console
                      print('Worker details:');
                      print(jsonEncode(worker.toMap()));
                      print('Phone number: ${worker.phone}');

                      if (worker.phone != null && worker.phone!.isNotEmpty) {
                        final phoneUrl = 'tel:${worker.phone}';
                        if (await canLaunchUrl(Uri.parse(phoneUrl))) {
                          await launchUrl(Uri.parse(phoneUrl));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not launch phone dialer'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Phone number not available'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.phone),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
