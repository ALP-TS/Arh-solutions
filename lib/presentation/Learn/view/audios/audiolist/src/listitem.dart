

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PremiumAudioListItem extends StatefulWidget {
  final String title =  "Blinding Lights";
  final String artist = "The Weeknd";
  final String duration = "3:20";
  // final String? albumArtUrl = "https://example.com/album-art.jpg";
  final bool isPlaying = true;
  // final bool isFavorite = true;
  final double progress = 0.65;
  // final String title;
  // final String artist;
  // final String duration;
  final String? coverArt;
  // final bool isPlaying;
  // final double progress;
  // final VoidCallback onTap;
  // final VoidCallback onPlayPressed;

  const PremiumAudioListItem({
    super.key, this.coverArt,
    // required this.title,
    // required this.artist,
    // required this.duration,
    // this.coverArt,
    // this.isPlaying = false,
    // this.progress = 0,
    // required this.onTap,
    // required this.onPlayPressed,
  });

  @override
  State<PremiumAudioListItem> createState() => _PremiumAudioListItemState();
}

class _PremiumAudioListItemState extends State<PremiumAudioListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {},
        // widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.grey[900]!.withOpacity(_isHovered ? 0.8 : 0.6)
                : Colors.white.withOpacity(_isHovered ? 0.9 : 1),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
            ],
            border: Border.all(
              color: isDark 
                  ? Colors.grey[800]!.withOpacity(0.5)
                  : Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Cover Art with Play Button Overlay
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: widget.coverArt != null
                              ? DecorationImage(
                                  image: NetworkImage(widget.coverArt!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: widget.coverArt == null
                              ? primaryColor.withOpacity(0.2)
                              : null,
                        ),
                        child: widget.coverArt == null
                            ? Icon(
                                Icons.music_note,
                                size: 28,
                                color: primaryColor.withOpacity(0.6),
                              )
                            : null,
                      ),
                      if (_isHovered || widget.isPlaying)
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: Icon(
                              widget.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: (){}
                            // widget.onPlayPressed,
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Track Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.artist,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Duration and Action Buttons
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.duration,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Like Button
                          // _buildIconButton(
                          //   icon: SvgPicture.asset(
                          //     'assets/icons/heart.svg',
                          //     color: Colors.grey,
                          //     width: 20,
                          //   ),
                          //   onPressed: () {},
                          // ),
                          const SizedBox(width: 8),
                          // More Options
                          _buildIconButton(
                            icon: Icon(
                              Icons.more_vert,
                              size: 20,
                              color: Colors.grey,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              
              // Progress Bar
              if (widget.isPlaying) ...[
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: widget.progress,
                  backgroundColor: theme.colorScheme.surface.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  minHeight: 3,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({required Widget icon, required VoidCallback onPressed}) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: icon,
      ),
    );
  }
}