import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:b_soft_appliction/app/config/theme/colors.dart';

import '../../../../../core/res/assets/images.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.bio,
    required this.image,
  });

  final String name, bio, image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: FadeInImage.assetNetwork(
            placeholder: AppImages.boyavathar,
            image: image,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppImages.boyavathar,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        bio,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}

class InfoCardShimmer extends StatelessWidget {
  const InfoCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Shimmer.fromColors(
        baseColor: Colors.grey[700]!,
        highlightColor: Colors.grey[500]!,
        child: CircleAvatar(
          backgroundColor: Colors.grey[700],
          radius: 24,
        ),
      ),
      title: Shimmer.fromColors(
        baseColor: Colors.grey[700]!,
        highlightColor: Colors.grey[500]!,
        child: Container(
          height: 16,
          width: double.infinity,
          color: Colors.grey[700],
          margin: const EdgeInsets.only(bottom: 4),
        ),
      ),
      subtitle: Shimmer.fromColors(
        baseColor: Colors.grey[700]!,
        highlightColor: Colors.grey[500]!,
        child: Container(
          height: 12,
          width: MediaQuery.of(context).size.width * 0.6,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
