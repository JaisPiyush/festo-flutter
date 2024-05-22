import 'package:festo_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';

class QuantityEditableItemCard extends StatefulWidget {
  final Item item;
  final void Function(double quantity) onQuantityChange;
  final void Function()? onRemove;
  const QuantityEditableItemCard(
      {super.key,
      required this.item,
      required this.onQuantityChange,
      this.onRemove});

  @override
  State<QuantityEditableItemCard> createState() =>
      _QuantityEditableItemCardState();
}

class _QuantityEditableItemCardState extends State<QuantityEditableItemCard> {
  double quantity = 1;

  @override
  void initState() {
    quantity = widget.item.quantity ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      surfaceTintColor: theme.colorScheme.background,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              child: Image.network(widget.item.images[0]),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: theme.textTheme.displaySmall!.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.item.brand_name,
                    style: theme.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.item.unit_value}${widget.item.unit_denomination}',
                    style: theme.textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\u20B9${(quantity * (widget.item.selling_price ?? 0)).toStringAsFixed(2)}',
                  style: theme.textTheme.titleSmall!
                      .copyWith(color: theme.colorScheme.primary),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputQty(
                  minVal: 0,
                  steps: 1,
                  initVal: quantity,
                  onQtyChanged: (val) {
                    final qty = double.parse(val.toString());
                    setState(() {
                      quantity = qty;
                      widget.onQuantityChange(qty);
                    });
                  },
                  decoration: QtyDecorationProps(
                      border: InputBorder.none,
                      fillColor: theme.scaffoldBackgroundColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
