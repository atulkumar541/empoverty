import 'package:flutter/material.dart';
import '../models/worker_model.dart';
import '../theme/app_theme.dart';
import 'rating_widget.dart';

class WorkerCard extends StatelessWidget {
  final Worker worker;
  final VoidCallback onTap;
  final VoidCallback? onCallTap;

  const WorkerCard({
    Key? key,
    required this.worker,
    required this.onTap,
    this.onCallTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Profile Image
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: worker.profileImageUrl != null
                        ? Image.network(
                            worker.profileImageUrl!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                            size: 30,
                            color: AppColors.grey,
                          ),
                  ),
                  const SizedBox(width: AppDimensions.paddingMedium),
                  // Worker Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                worker.name,
                                style: AppTypography.subtitle2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (worker.isVerified) ...[
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.verified,
                                color: AppColors.success,
                                size: 16,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          worker.category,
                          style: AppTypography.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        RatingWidget(
                          rating: worker.rating,
                          reviewCount: worker.reviewCount,
                        ),
                      ],
                    ),
                  ),
                  // Call Button
                  if (onCallTap != null)
                    IconButton(
                      onPressed: onCallTap,
                      icon: const Icon(
                        Icons.call,
                        color: AppColors.primary,
                      ),
                    ),
                ],
              ),
              if (worker.bio != null) ...[
                const SizedBox(height: AppDimensions.paddingSmall),
                Text(
                  worker.bio!,
                  style: AppTypography.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (worker.skills.isNotEmpty) ...[
                const SizedBox(height: AppDimensions.paddingSmall),
                Wrap(
                  spacing: 4,
                  children: worker.skills
                      .take(3)
                      .map((skill) => Chip(
                            label: Text(
                              skill,
                              style: const TextStyle(fontSize: 11),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
