import 'package:bloc/bloc.dart';
import 'package:cartzy_app/feature/cart/data/model/response/cart_item_model.dart';
import 'package:cartzy_app/feature/cart/data/repo/repository/cart_repository.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepository) : super(CartInitial());
  CartRepository cartRepository;
  List<CartItemModel> cartItems = [];
  double totalPrice = 0.0;

  Future<void> getAllCartItems() async {
    emit(CartLoading());
    cartItems = await cartRepository.getAllCartItems();
    emit(CartSuccess());
  }

  Future<void> removeItemFromCart(int productId) async {
    await cartRepository.removeItemFromCart(productId);
    emit(CartSuccess());
  }

  Future<void> updateItemQuantity(int productId, int quantity) async {
    await cartRepository.updateItemQuantity(productId, quantity);
    emit(CartSuccess());
  }

  void calculateTotalPrice() {
    totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += item.price * item.quantity;
    }
    emit(CartSuccess());
  }
}
