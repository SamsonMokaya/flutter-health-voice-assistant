import 'package:flutter/material.dart';

ClipRRect carvedEdgeImage(
    {imageHeight, imageWidth, radius = 0.0, imageURL, network = false}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: SizedBox(
      height: imageHeight,
      width: imageWidth,
      child: network
          ? Image.network(
              imageURL,
              fit: BoxFit.fill,
            )
          : Image.asset(
              imageURL,
              fit: BoxFit.contain,
            ),
    ),
  );
}
