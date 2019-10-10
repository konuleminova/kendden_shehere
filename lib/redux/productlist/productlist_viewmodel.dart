import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:kendden_shehere/redux/productlist/thunk_productlist.dart';
import 'package:redux/redux.dart';

class ProductListViewModel {
  Function(String id, String lang, String limit, String page, String order)
  onFetchProductList;
  List<NewProduct> productList;
  Function(String order) changeOrder;
  String order;
  Function(String id, String lang, String limit, String page, String order)
  onLoadMoreProductList;
  Function(String id, String lang, String limit, String page, String order)
  onChangeProductList;
  Function(int index, bool isLiked) changeStatus;
  Function(int index, bool isAdded, int weight) changeAddStatus;

  ProductListViewModel({this.onFetchProductList,
    this.productList,
    this.changeOrder,
    this.order,
    this.onLoadMoreProductList,
    this.onChangeProductList,
    this.changeStatus, this.changeAddStatus});

  factory ProductListViewModel.create(Store<AppState> store) {
    _onFetchProductList(String id, String lang, String limit, String page,
        String order) {
      store.dispatch(
          productListThunkAction(id, lang, limit, page, order, "init"));
    }

    _onLoadMoreProductList(String id, String lang, String limit, String page,
        String order) {
      store.dispatch(
          productListThunkAction(id, lang, limit, page, order, "loadMore"));
    }

    _onChangeOrderProductList(String id, String lang, String limit, String page,
        String order) {
      store.dispatch(
          productListThunkAction(id, lang, limit, page, order, "change"));
    }

    _onChangeStatusProductList(int index, bool isLiked) {
      store.dispatch(StatusAction(index, isLiked));
    }
    _onChangeAddStatusProductList(int index, bool isAdded,int weight) {
      store.dispatch(AddStatusAction(index, isAdded,weight));
    }

    return ProductListViewModel(
        productList: store.state.newProducts,
        onFetchProductList: _onFetchProductList,
        onLoadMoreProductList: _onLoadMoreProductList,
        order: store.state.filterOrder,
        onChangeProductList: _onChangeOrderProductList,
        changeStatus: _onChangeStatusProductList,
        changeAddStatus:_onChangeAddStatusProductList);
  }
}
