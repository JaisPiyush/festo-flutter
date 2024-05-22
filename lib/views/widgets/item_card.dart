import 'package:festo_app/models/item.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback? onClick;
  final bool? isSelected;
  const ItemCard(
      {super.key, required this.item, this.onClick, this.isSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      surfaceTintColor: theme.colorScheme.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isSelected == true
              ? const BorderSide(color: Colors.green, width: 3)
              : const BorderSide(color: Colors.grey, width: 2)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return InkWell(
            onTap: () {
              if (onClick != null) {
                onClick!();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.network(
                    item.images[0],
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: Image.network(item.images[0]),
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
                            item.name,
                            style: theme.textTheme.labelMedium!.copyWith(
                                fontSize: 12, overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            item.brand_name,
                            style: theme.textTheme.labelSmall!.copyWith(
                                fontSize: 10, overflow: TextOverflow.ellipsis),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\u20B9${item.selling_price}',
                                style: theme.textTheme.labelMedium!.copyWith(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                '${item.unit_value}${item.unit_denomination}',
                                style: theme.textTheme.labelSmall!.copyWith(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis),
                              )
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
