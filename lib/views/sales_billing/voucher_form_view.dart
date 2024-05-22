import 'package:festo_app/models/item.dart';
import 'package:festo_app/views/widgets/index_based_record_controller.dart';
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
  late IndexBasedRecordController<double> _quantityController;

  @override
  void initState() {
    _quantityController = IndexBasedRecordController.fromList(
        widget.items.map((e) => 1.0).toList());
    _quantityController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  double getTotalSum() {
    double sum = 0;
    for (int index = 0; index < widget.items.length; index++) {
      sum += (widget.items[index].selling_price ?? 0) *
          (_quantityController.record[index] ?? 0);
    }
    return sum;
  }

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
                  onQuantityChange: (quantity) {
                    _quantityController.setRecord(index, quantity);
                  },
                  onRemove: () {})),
        )),
        SaleVoucherItemTotal(
          itemTotal: getTotalSum(),
          taxTotal: 0,
          onNext: () {},
        )
      ],
    );
  }
}
