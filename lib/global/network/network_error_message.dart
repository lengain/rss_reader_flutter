
import 'network_result.dart';

class NetworkResultMessageInterceptor extends NetworkResultInterceptor {

  NetworkResultMessageInterceptor(this.context);
  var context;

  @override
  void interceptNetworkResult(NetworkResult result, {showMessage = true}) {
    if (showMessage == true && result.success == false) {
      String message = result.error?.message ?? "";
      // GlobalHandler.showToast(message, context);
    }
  }
}