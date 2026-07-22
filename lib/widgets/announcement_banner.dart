import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AnnouncementBanner extends StatelessWidget {
  final String title;
  final String channelName;
  final String description;
  final VoidCallback? onSubscribe;

  const AnnouncementBanner({
    Key? key,
    this.title = 'NEW UPLOAD',
    this.channelName = 'NSIL GAMING',
    this.description = 'PUBG Mobile - Chicken dinners & ranked pushes',
    this.onSubscribe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: AppColors.bannerGradient,
        border: Border.all(
          color: AppColors.accentGold.withOpacity(0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGold.withOpacity(0.08),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left Target Icon inside amber circle
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withOpacity(0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accentGold.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.center_focus_strong,
              color: AppColors.accentGold,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),

          // Center Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.accentGold,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        color: AppColors.accentGold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  channelName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Subscribe Button
          GestureDetector(
            onTap: onSubscribe,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.accentGold,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentGold.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.play_arrow_rounded,
                    color: Color(0xFF1F1807),
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Subscribe',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F1807),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
