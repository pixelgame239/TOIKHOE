import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/database/fetch_userID_password.dart';

// Trạng thái đăng nhập
class LoginState {
  final String errorMessage;
  final bool isValid;
  final bool isLoading;
  final bool isLoggedIn;

  LoginState({
    this.errorMessage = '',
    this.isValid = true,
    this.isLoading = false,
    this.isLoggedIn = false,
  });

  LoginState copyWith({
    String? errorMessage,
    bool? isValid,
    bool? isLoading,
    bool? isLoggedIn,
  }) {
    return LoginState(
      errorMessage: errorMessage ?? this.errorMessage,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

// Provider trạng thái đăng nhập
class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  Map<String, int> loginAttempts = {};

  Future<void> authenticateUser(String userName, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      List<Map<String, String>> accounts = await fetchTaiKhoanInfo().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception(
              'Kết nối tới cơ sở dữ liệu bị chậm. Vui lòng thử lại.');
        },
      );

      for (var account in accounts) {
        if (account['userID'] == userName) {
          if (account['password'] == password) {
            loginAttempts.remove(userName);
            state = state.copyWith(isLoggedIn: true, isLoading: false);
            return;
          } else {
            loginAttempts[userName] = (loginAttempts[userName] ?? 0) + 1;

            if (loginAttempts[userName]! >= 5) {
              state = state.copyWith(
                  errorMessage: 'Tài khoản đã bị khóa.',
                  isValid: false,
                  isLoading: false);
              return;
            }
            state = state.copyWith(
                errorMessage: 'Sai mật khẩu', isValid: false, isLoading: false);
            return;
          }
        }
      }
      state = state.copyWith(
          errorMessage: 'Tài khoản không tồn tại',
          isValid: false,
          isLoading: false);
    } catch (e) {
      state = state.copyWith(
          errorMessage: 'Lỗi kết nối tới máy chủ. Vui lòng thử lại sau!',
          isValid: false,
          isLoading: false);
    }
  }

  void resetError() {
    state = state.copyWith(errorMessage: '', isValid: true);
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
