import 'package:festo_app/models/item.dart';
import 'package:festo_app/views/widgets/quantity_editable_item_card.dart';
import 'package:festo_app/views/widgets/sale_voucher_item_total.dart';
import 'package:flutter/material.dart';

class VoucherFormView extends StatefulWidget {
  final List<Item> items;
  const VoucherFormView({super.key, required this.items});

  @override
  State<VoucherFormView> createState() => _VoucherFormViewState();
}

class _VoucherFormViewState extends State<VoucherFormView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) => QuantityEditableItemCard(
                  item: widget.items[index],
                  onQuantityChange: (double quantity) {},
                  onRemove: () {})),
        )),
        SaleVoucherItemTotal(
          itemTotal: 10005.55,
          taxTotal: 256.5,
          onNext: () {},
        )
      ],
    );
  }
}
