import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/register/register_thunk.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/login/thunk_login.dart';

class RegisterViewModel {
  Function(String lang, UserModel userModel) buildRegister;

  RegisterViewModel({this.buildRegister});

  factory RegisterViewModel.create(Store<AppState> store) {
    _buildRegister(String lang, UserModel userModel) {
      store.dispatch(registerThunkFunction(lang, userModel));
    }

    return RegisterViewModel(buildRegister: _buildRegister);
  }
}
