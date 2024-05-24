import 'package:festo_app/api/client.dart';
import 'package:festo_app/bloc/sales_billing/sales_billing.cubit.dart';
import 'package:festo_app/bloc/sales_billing/sales_billing.state.dart';
import 'package:festo_app/routes.dart';
import 'package:festo_app/views/sales_billing/voucher_form_view.dart';
import 'package:festo_app/views/vision_search/vision_search_view.dart';
import 'package:festo_app/views/widgets/image_picker_widget.dart';
import 'package:festo_app/views/widgets/item_card.dart';
import 'package:festo_app/views/widgets/item_card_with_bounded_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesBillingView extends StatefulWidget {
  final String? imageUrl;
  const SalesBillingView({super.key, this.imageUrl});

  @override
  State<SalesBillingView> createState() => _SalesBillingViewState();
}

class _SalesBillingViewState extends State<SalesBillingView> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as SalesBillingViewRouteArgs?;
    final _imageUrl = widget.imageUrl ?? args?.imageUrl;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sales'),
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: BlocProvider(
          create: (context) {
            final cubit =
                SalesBillingCubit(RepositoryProvider.of<ApiClient>(context));
            if (_imageUrl != null) {
              cubit.visionSearchItemsFromInventory(_imageUrl);
            }
            return cubit;
          },
          child: BlocBuilder<SalesBillingCubit, SalesBillingState>(
            builder: (context, state) {
              if (state is SalesBillingVisionSearchState) {
                return VisionSearchView(
                  cubit: BlocProvider.of<SalesBillingCubit>(context),
                  showOnNext: (state) {
                    return state
                        is SalesBillingVisionSearchBoundedImageWithBestMatchingItemVisible;
                  },
                  onNext: () {
                    BlocProvider.of<SalesBillingCubit>(context)
                        .showVoucherCreationForm();
                  },
                  getResultCard: (context, state, index) {
                    if (state
                        is SalesBillingVisionSearchBoundedImageWithBestMatchingItemVisible) {
                      return ItemCardWithBoundedBox(
                        key: Key(index.toString()),
                        sourceImageUrl: state.sourceImageUrl,
                        boundingPoly: state.boundingPolys[index],
                        selectedItem: state.selectedItems[index],
                        onClick: () {
                          BlocProvider.of<SalesBillingCubit>(context)
                              .showSalesBillingVisionSearchMatchingItemsVisible(
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
                          final cubit =
                              BlocProvider.of<SalesBillingCubit>(context);
                          cubit.selectedItems[state.boundedImageIndex] = item;
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
              } else if (state is SalesBillingImagePickerVisibleState) {
                return ImagePickerWidget(
                    title: 'Select image for sales voucher creation',
                    onImagePick: (file) async {
                      await BlocProvider.of<SalesBillingCubit>(context)
                          .uploadImageAndStartVisionSearch(file);
                    });
              } else if (state is SalesBillingVoucherFormVisibleState) {
                return VoucherFormView(items: state.items);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
