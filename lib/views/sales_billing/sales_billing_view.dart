import 'package:festo_app/bloc/sales_billing/sales_billing.cubit.dart';
import 'package:festo_app/bloc/sales_billing/sales_billing.state.dart';
import 'package:festo_app/views/vision_search/vision_search_view.dart';
import 'package:festo_app/views/widgets/item_card.dart';
import 'package:festo_app/views/widgets/item_card_with_bounded_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesBillingView extends StatefulWidget {
  const SalesBillingView({super.key});

  @override
  State<SalesBillingView> createState() => _SalesBillingViewState();
}

class _SalesBillingViewState extends State<SalesBillingView> {
  @override
  Widget build(BuildContext context) {
    SalesBillingCubit cubit = SalesBillingCubit();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sales'),
          backgroundColor: Colors.white,
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        ),
        body: RepositoryProvider(
          create: (context) {
            return cubit;
          },
          child: BlocBuilder<SalesBillingCubit, SalesBillingState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is SalesBillingInitialState) {
                cubit.visionSearchItemsFromInventory(
                    'https://storage.googleapis.com/vyser-product-database/kissan-fresh-tomato-ketchup/20240517_132710.png');
              }
              return VisionSearchView(
                cubit: cubit,
                getResultCard: (context, state, index) {
                  if (state
                      is SalesBillingVisionSearchBoundedImageWithBestMatchingItemVisible) {
                    return ItemCardWithBoundedBox(
                      key: Key(index.toString()),
                      sourceImageUrl: state.sourceImageUrl,
                      boundingPoly: state.boundingPolys[index],
                      selectedItem: state.selectedItems[index],
                      onClick: () {
                        cubit.showSalesBillingVisionSearchMatchingItemsVisible(
                            state.sourceImageUrl,
                            state.response,
                            index,
                            state.selectedItems[index]);
                      },
                    );
                  } else if (state
                      is SalesBillingVisionSearchMatchingItemsVisible) {
                    final item = state.selectableItems[index];
                    return ItemCard(
                      item: item,
                      isSelected: state.selectedItem == item,
                      onClick: () {
                        cubit.selectedItems[index] = item;
                        cubit
                            .showSalesBillingVisionSearchBoundedImageWithBestMatchingItemVisible(
                                state.sourceImageUrl,
                                state.response,
                                cubit.selectedItems);
                      },
                    );
                  }
                  return const Placeholder();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
