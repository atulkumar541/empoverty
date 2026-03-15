import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final TextStyle? ratingTextStyle;
  final TextStyle? reviewTextStyle;

  const RatingWidget({
    Key? key,
    required this.rating,
    required this.reviewCount,
    this.ratingTextStyle,
    this.reviewTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Color(0xFFFFC107),
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: ratingTextStyle ?? AppTypography.subtitle2,
        ),
        const SizedBox(width: 4),
        Text(
          '($reviewCount)',
          style: reviewTextStyle ?? AppTypography.bodyMedium,
        ),
      ],
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color filledColor;
  final Color emptyColor;

  const StarRating({
    Key? key,
    required this.rating,
    this.size = 24,
    this.filledColor = const Color(0xFFFFC107),
    this.emptyColor = const Color(0xFFE0E0E0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: size,
          color: index < rating.floor() ? filledColor : emptyColor,
        );
      }),
    );
  }
}
