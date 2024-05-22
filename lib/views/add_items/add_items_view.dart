import 'package:festo_app/bloc/add_items/add_items.cubit.dart';
import 'package:festo_app/bloc/add_items/add_items.state.dart';
import 'package:festo_app/routes.dart';
import 'package:festo_app/views/add_items/add_items_mutation_form.dart';
import 'package:festo_app/views/add_items/add_items_vision_product_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemsPage extends StatelessWidget {
  final String? imageUrl;
  const AddItemsPage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as AddItemsViewRouteArgs?;
    final _imageUrl = imageUrl ?? args?.imageUrl;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Create Items'),
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
          final cubit = AddItemsCubit();
          if (_imageUrl != null) {
            cubit.visionSearchItemFromGlobalCatalog(_imageUrl);
          }
          return cubit;
        },
        child: BlocBuilder<AddItemsCubit, AddItemsState>(
          builder: (context, state) {
            if (state is AddItemsVisionSearchState) {
              final cubit = BlocProvider.of<AddItemsCubit>(context);
              return AddItemsVisionProductSelectionView(
                cubit: cubit,
                onNextClick: (items) {
                  cubit.showInventoryMutationForms();
                },
              );
            } else if (state is AddItemsInventoryMutationFormVisible) {
              return AddItemsMutationForm(items: state.items);
            } else if (state is AddItemsInventoryMutationCompletedState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop();
              });
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    ));
  }
}
