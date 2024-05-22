import 'package:festo_app/samples.dart';
import 'package:festo_app/views/sales_billing/voucher_form_view.dart';
import 'package:festo_app/views/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';

class SalesBillingView extends StatefulWidget {
  const SalesBillingView({super.key});

  @override
  State<SalesBillingView> createState() => _SalesBillingViewState();
}

class _SalesBillingViewState extends State<SalesBillingView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sales'),
          backgroundColor: Colors.white,
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        ),
        body: VoucherFormView(items: sampleItems),
      ),
    );
  }
}
