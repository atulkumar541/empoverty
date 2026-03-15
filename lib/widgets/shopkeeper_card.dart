import 'package:flutter/material.dart';
import '../models/shopkeeper_model.dart';
import '../theme/app_theme.dart';
import 'rating_widget.dart';

class ShopkeeperCard extends StatelessWidget {
  final Shopkeeper shopkeeper;
  final VoidCallback onTap;
  final bool showAddress;

  const ShopkeeperCard({
    Key? key,
    required this.shopkeeper,
    required this.onTap,
    this.showAddress = true,
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
              // Shop Image
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                child: shopkeeper.shopImageUrl != null
                    ? Image.network(
                        shopkeeper.shopImageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.store,
                        size: 50,
                        color: AppColors.grey,
                      ),
              ),
              const SizedBox(height: AppDimensions.paddingMedium),
              // Shop Name
              Text(
                shopkeeper.shopName,
                style: AppTypography.subtitle1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // Description
              Text(
                shopkeeper.description,
                style: AppTypography.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Address
              if (showAddress && shopkeeper.address != null)
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        shopkeeper.address!,
                        style: AppTypography.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 8),
              // Services and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 4,
                      children: shopkeeper.offeredServices
                          .take(2)
                          .map((service) => Chip(
                                label: Text(
                                  service,
                                  style: const TextStyle(fontSize: 11),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  RatingWidget(
                    rating: shopkeeper.rating,
                    reviewCount: shopkeeper.reviewCount,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
