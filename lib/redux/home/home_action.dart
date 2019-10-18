import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/home/home_list.dart';

class ShowAllCollectionAction {
  HomeList homeList;

  ShowAllCollectionAction({this.homeList});
}

class ShowHomeBasketAction {
  Store<AppState> store;

  ShowHomeBasketAction(this.store);
}
class ShowHomeWishAction{
  Store<AppState> store;

  ShowHomeWishAction(this.store);
}