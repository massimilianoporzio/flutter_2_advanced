import 'package:flutter_2_advanced/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCartBloc
    extends Bloc<ShoppingCartBlocEvent, ShoppingCartBlocState> {
  ShoppingCartBloc() : super(ShoppingCartBlocStateLoading()) {
    //QUANDO riceve un evento Init genera lo stato LOADING
    on<ShoppingCartBlockEventInit>(
      (event, emit) async {
        emit(ShoppingCartBlocStateLoading());
        await Future.delayed(const Duration(seconds: 2));
        emit(ShoppingCartBlocStateLoaded(products)); //simulo  chiamata API
      },
    );
  }
}

abstract class ShoppingCartBlocEvent {}

//*mi rappresentano gli eventi associati allo ShoppingCart bloc
class ShoppingCartBlockEventInit extends ShoppingCartBlocEvent {}

abstract class ShoppingCartBlocState {}

//*mi rappresentano gli stati del mio bloc ShoppingCart
class ShoppingCartBlocStateLoading extends ShoppingCartBlocState {}

class ShoppingCartBlocStateLoaded extends ShoppingCartBlocState {
  List<ProductModel> products;
  ShoppingCartBlocStateLoaded(this.products);
}
