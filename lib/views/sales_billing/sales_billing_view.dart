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
        body: Center(
          child: ImagePickerWidget(
            title: 'Select image for creating order',
            onImagePick: (image) {},
          ),
        ),
      ),
    );
  }
}
