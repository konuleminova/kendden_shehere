import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> getProductListThunkAction(int limit, int page) {
  return (Store<AppState> store) async {
    Home response = await Networks.fetchProducts(limit, page);
    if (response != null) {
      store.state.home = response;
      store.dispatch(
          FetchProductsAction(result: response.result, data: response.data));
    }
  };
}
