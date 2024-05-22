import 'package:festo_app/bloc/add_items/add_items.cubit.dart';
import 'package:festo_app/models/catalog_item.dart';
import 'package:festo_app/models/item.dart';
import 'package:festo_app/views/widgets/index_based_record_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class AddItemsMutationForm extends StatefulWidget {
  final List<CatalogItem> items;
  const AddItemsMutationForm({super.key, required this.items});

  @override
  State<AddItemsMutationForm> createState() => _AddItemsMutationFormState();
}

class _AddItemsMutationFormState extends State<AddItemsMutationForm> {
  late IndexBasedRecordController<double> _quantityController;
  late IndexBasedRecordController<double?> _reorderLevelController;
  late IndexBasedRecordController<double> _sellingPriceController;

  @override
  void initState() {
    _quantityController = IndexBasedRecordController.fromList(
        widget.items.map<double>((e) => 0).toList());
    _sellingPriceController = IndexBasedRecordController.fromList(
        widget.items.map<double>((e) => e.selling_price ?? 0).toList());
    _reorderLevelController = IndexBasedRecordController.fromList(
        widget.items.map((e) => null).toList());
    _quantityController.addListener(() {
      setState(() {});
    });
    _sellingPriceController.addListener(() {
      setState(() {});
    });
    _reorderLevelController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  final formFields = {
    'quantity': 'Quantity',
    'selling_price': 'Selling Price',
    'reorder_level': 'Reorder level'
  };

  List<Widget> getItemForm(BuildContext context, item, int index) {
    final theme = Theme.of(context);
    final json = item.toJson();
    return formFields.keys.map((field) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              formFields[field]!,
              style: theme.textTheme.labelMedium,
            ),
            InputQty(
              minVal: 0,
              steps: 1,
              initVal: json[field] ?? 0,
              decoration: QtyDecorationProps(
                  border: InputBorder.none,
                  fillColor: theme.scaffoldBackgroundColor),
              onQtyChanged: (val) {
                final qty = double.parse(val.toString());
                switch (field) {
                  case 'quantity':
                    _quantityController.setRecord(index, qty);
                    break;
                  case 'selling_price':
                    _sellingPriceController.setRecord(index, qty);
                    break;
                  case 'reorder_level':
                    _reorderLevelController.setRecord(
                        index, qty == 0 ? null : qty);
                    break;
                }
                setState(() {});
                // onQuantityChange(qty);
              },
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return Card(
                    elevation: 0,
                    surfaceTintColor: theme.colorScheme.background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    key: Key(index.toString()),
                    child: Column(
                      children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    child: Image.network(item.images[0]),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    item.name,
                                    style: theme.textTheme.labelLarge,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: theme.scaffoldBackgroundColor,
                            ),
                          ] +
                          getItemForm(context, item, index),
                    ),
                  );
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        List<Item> items =
                            _sellingPriceController.record.entries.map((e) {
                          CatalogItem item = widget.items[e.key];
                          return Item.fromCatalogItem(
                              item,
                              e.value,
                              _quantityController.record[e.key]!,
                              _reorderLevelController.record[e.key]);
                        }).toList();
                        BlocProvider.of<AddItemsCubit>(context)
                            .addItemsToInventory(items);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          foregroundColor: theme.colorScheme.background,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Text('Continue')))
            ],
          ),
        )
      ],
    );
  }
}
