import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_linker_new/theme/app_colors.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final BoxFit fit;
  final bool isCircular;
  final double borderRadius;

  const CachedImage({
    Key? key,
    this.imageUrl,
    this.size = 80,
    this.fit = BoxFit.cover,
    this.isCircular = true,
    this.borderRadius = 12.0,
  }) : super(key: key);

  bool get _isValidUrl => imageUrl != null && imageUrl!.isNotEmpty;

  bool get _isLocalImage =>
      _isValidUrl && (imageUrl!.startsWith('/') || imageUrl!.startsWith('file://'));

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular ? null : BorderRadius.circular(borderRadius),
        color: const Color.fromARGB(255, 192, 191, 191),
      ),
      child: Icon(Icons.person, size: size * 0.5, color: AppColors.primary),
    );

    if (!_isValidUrl) return fallback;

    final imageWidget = _isLocalImage
        ? Image.file(
            File(imageUrl!),
            width: size,
            height: size,
            fit: fit,
            errorBuilder: (context, error, stackTrace) => fallback,
          )
        : CachedNetworkImage(
            imageUrl: imageUrl!,
            width: size,
            height: size,
            fit: fit,
            placeholder: (context, url) => Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
            errorWidget: (context, url, error) => fallback,
          );

    return isCircular
        ? ClipOval(child: imageWidget)
        : ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            clipBehavior: Clip.hardEdge,
            child: imageWidget,
          );
  }
}
