import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/login/thunk_login.dart';
class ViewModel {
  Function(String username,String password) buildLogin;

  ViewModel({this.buildLogin});

  factory ViewModel.create(Store<AppState> store) {
    _buildLogin(String username,String password) {
      store.dispatch(loginThunkFunction(username,password));
    }
    return ViewModel(
        buildLogin: _buildLogin);
  }
}
