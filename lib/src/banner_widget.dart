import 'package:banner_carousel/banner_carousel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

@immutable
class BannerWidget extends StatelessWidget {
  final BannerModel _bannerModel;

  /// The [borderRadius] of the container
  /// Default value 5
  final double borderRadius;

  /// The [_onTap] The Method when click on the Banner
  final VoidCallback _onTap;

  final double spaceBetween;

  BannerWidget({
    Key? key,
    required BannerModel bannerModel,
    this.borderRadius = 5,
    this.spaceBetween = 0,
    required VoidCallback onTap,
  }) : _bannerModel = bannerModel,
       _onTap = onTap,
       super(key: key);

  Widget _buildImage() {
    if (_bannerModel.imagePath.contains("https://") ||
        _bannerModel.imagePath.contains("http://")) {
      return CachedNetworkImage(
        imageUrl: _bannerModel.imagePath,
        fit: _bannerModel.boxFit,
        width: double.maxFinite,
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) =>
            Container(color: Colors.grey[300], child: const Icon(Icons.error)),
      );
    } else {
      return Image.asset(
        _bannerModel.imagePath,
        fit: _bannerModel.boxFit,
        width: double.maxFinite,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: spaceBetween),
        width: double.maxFinite,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: _buildImage(),
        ),
      ),
    );
  }
}
