import 'package:flutter_2_advanced/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCartBloc
    extends Bloc<ShoppingCartBlocEvent, ShoppingCartBlocState> {
  ShoppingCartBloc() : super(ShoppingCartBlocStateLoading()) {
    //*QUI CI SONO LE LOGICHE DI BUSINESS!
    //QUANDO riceve un evento Init genera lo stato LOADING
    on<ShoppingCartBlockEventInit>(
      (event, emit) async {
        emit(ShoppingCartBlocStateLoading());
        await Future.delayed(const Duration(seconds: 2));
        emit(ShoppingCartBlocStateLoaded(products)); //simulo  chiamata API
      },
    );

    on<ShoppingCartBlockEventToggle>(
      (event, emit) {
        //*prendo i prodotti
        final products = (state as ShoppingCartBlocStateLoaded).products;
        //*cerco il prodotto = a quello che mi arriva nell'evento
        final product = products
            .firstWhere((element) => element.name == event.product.name);
        product.nelCarrello = !product.nelCarrello; //*faccio il toggle
        //*EMETTO DI NUOVO EVENTO DI LOADED
        emit(ShoppingCartBlocStateLoaded(products));
      },
    );
  }
}

abstract class ShoppingCartBlocEvent {}

//*mi rappresentano gli eventi associati allo ShoppingCart bloc
//evento Init
class ShoppingCartBlockEventInit extends ShoppingCartBlocEvent {}

//evento toggle (togli/metti)
class ShoppingCartBlockEventToggle extends ShoppingCartBlocEvent {
  final ProductModel product;

  ShoppingCartBlockEventToggle({required this.product});
}

abstract class ShoppingCartBlocState {}

//*mi rappresentano gli stati del mio bloc ShoppingCart
class ShoppingCartBlocStateLoading extends ShoppingCartBlocState {}

class ShoppingCartBlocStateLoaded extends ShoppingCartBlocState {
  List<ProductModel> products;
  ShoppingCartBlocStateLoaded(this.products);
}
