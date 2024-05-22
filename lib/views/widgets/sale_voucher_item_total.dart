import 'package:flutter/material.dart';

class SaleVoucherItemTotal extends StatelessWidget {
  final double itemTotal;
  final double taxTotal;
  final void Function() onNext;
  const SaleVoucherItemTotal(
      {super.key,
      required this.itemTotal,
      required this.taxTotal,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.background,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Bill Details',
              style: theme.textTheme.labelLarge,
            ),
          ),
          Divider(
            color: theme.scaffoldBackgroundColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Item Total',
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  '\u20B9${itemTotal}',
                  style: theme.textTheme.labelMedium,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Tax',
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  '\u20B9${taxTotal}',
                  style: theme.textTheme.bodySmall,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'To Pay',
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  '\u20B9${itemTotal + taxTotal}',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    onNext();
                  },
                  child: Text('Sale'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: theme.colorScheme.surface,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
