import 'package:festo_app/models/abstract_item.dart';
import 'package:festo_app/models/vision_search/normalized_vertex.dart';
import 'package:festo_app/views/widgets/bounding_box.dart';
import 'package:flutter/material.dart';

class ItemCardWithBoundedBox extends StatelessWidget {
  final String sourceImageUrl;
  final BoundingPoly boundingPoly;
  final AbstractItem? selectedItem;
  final VoidCallback? onClick;
  final VoidCallback? onRemoveClick;

  const ItemCardWithBoundedBox(
      {super.key,
      required this.sourceImageUrl,
      required this.boundingPoly,
      this.selectedItem,
      this.onClick,
      this.onRemoveClick});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      surfaceTintColor: theme.colorScheme.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: selectedItem != null
              ? const BorderSide(color: Colors.green, width: 3)
              : const BorderSide(color: Colors.grey, width: 2)),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              if (onClick != null) {
                onClick!();
              }
            },
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                      height: constraints.maxHeight *
                          (selectedItem == null ? 1 : 0.6),
                      child: BoundingBoxWidget(
                          imageUrl: sourceImageUrl,
                          boundingPoly: boundingPoly)),
                  if (selectedItem != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            child: Image.network(selectedItem!.images[0]),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                selectedItem!.name,
                                style: theme.textTheme.labelMedium!.copyWith(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                selectedItem!.brand_name,
                                style: theme.textTheme.labelSmall!.copyWith(
                                    fontSize: 10,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                '${selectedItem!.unit_value}${selectedItem!.unit_denomination}',
                                style: theme.textTheme.labelSmall!.copyWith(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ))
                        ],
                      ),
                    )
                ],
              );
            }),
          ),
          Positioned(
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                style: IconButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  if (onRemoveClick != null) {
                    onRemoveClick!();
                  }
                },
              ))
        ],
      ),
    );
  }
}
