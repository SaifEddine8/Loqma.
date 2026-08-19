import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OfferImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;

  const OfferImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = _buildImage();

    // تطبيق الـ BorderRadius إذا تم تمريره
    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildImage() {
    final String path = imagePath.trim();

    // 1. في حال كان المسار رابط إنترنت (http / https) أو كنا نعمل على بيئة الويب
    if (path.startsWith('http://') || path.startsWith('https://') || kIsWeb) {
      return Image.network(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }

    // 2. تنظيف المسار في حال كان يبدأ بـ file://
    final cleanPath = path.startsWith('file://')
        ? path.replaceFirst('file://', '')
        : path;

    final file = File(cleanPath);

    // 3. قراءة الملف من الذاكرة المحلية للجهاز
    if (file.existsSync()) {
      return Image.file(
        file,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }

    // 4. صورة افتراضية في حال عدم العثور على الملف
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade300,
      child: const Icon(
        Icons.fastfood,
        size: 50,
        color: Colors.grey,
      ),
    );
  }
}