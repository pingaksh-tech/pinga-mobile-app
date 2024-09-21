import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.size = 24.0,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the number of full, half, and empty stars
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    List<Widget> stars = [];

    // Add full stars
    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star_rounded, size: size, color: color));
    }

    // Add half star if needed
    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half_rounded, size: size, color: color));
    }

    // Add empty stars
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(Icons.star_border_rounded, size: size, color: color));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}
