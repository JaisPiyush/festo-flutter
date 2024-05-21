import 'package:equatable/equatable.dart';

class SalesBillingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SalesBillingInitialState extends SalesBillingState {}

class SalesBillingLoadingState extends SalesBillingState {}

class SalesBillingImagePickerVisibleState extends SalesBillingState {}

class SalesBillingVisionSearchingProductState extends SalesBillingState {
  final String sourceImageUrl;
  SalesBillingVisionSearchingProductState(this.sourceImageUrl);

  @override
  List<Object?> get props => [sourceImageUrl];
}
