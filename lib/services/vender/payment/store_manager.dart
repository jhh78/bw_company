import 'package:in_app_purchase/in_app_purchase.dart';

abstract class StoreManager {
  void initialize();
  void buyProduct(int index);
  void dispose();
  Future<void> loadProducts();
  void listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList);
  void showSnackbar();
}
