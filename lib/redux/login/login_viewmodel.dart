import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/login/thunk_login.dart';
class LoginViewModel {
  Function(String username,String password) buildLogin;
  STATUS status;

  LoginViewModel({this.buildLogin,this.status});

  factory LoginViewModel.create(Store<AppState> store) {
    _buildLogin(String username,String password) {
      store.dispatch(loginThunkFunction(username,password));
    }
    return LoginViewModel(
        buildLogin: _buildLogin,status:store.state.user_info.status);
  }
}
