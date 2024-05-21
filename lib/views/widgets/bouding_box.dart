import 'package:festo_app/models/vision_search/normalized_vertex.dart';
import 'package:flutter/material.dart';

class BoundingBoxWidget extends StatelessWidget {
  final String imageUrl;
  final BoundingPoly boundingPoly;

  BoundingBoxWidget({required this.imageUrl, required this.boundingPoly});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double imageWidth = constraints.maxWidth;
        final double imageHeight = constraints.maxHeight;

        final List<NormalizedVertex> vertices =
            List<NormalizedVertex>.from(boundingPoly.normalized_vertices);
        final double left = vertices[0].x * imageWidth;
        final double top = vertices[0].y * imageHeight;
        final double right = vertices[2].x * imageWidth;
        final double bottom = vertices[2].y * imageHeight;

        final double boxWidth = right - left;
        final double boxHeight = bottom - top;

        return Stack(
          children: [
            Image.network(
              imageUrl,
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.contain,
            ),
            Positioned(
              left: left,
              top: top,
              child: Container(
                width: boxWidth,
                height: boxHeight,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
