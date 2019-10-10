import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> getProductListThunkAction(String id) {
  return (Store<AppState> store) async {
    var response = await Networks().getCollectionItem(id);
    if (response != null) {
      store.dispatch(
          FetchProductsAction(data: response));
    }
  };
}
ThunkAction<AppState> getCollectionCountThunk() {
  return (Store<AppState> store) async {
    var response = await Networks().getCollections();
    print("Collection");
    if (response != null) {
      store.dispatch(
          CollectionAction(collection: response));
    }
  };
}