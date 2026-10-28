import 'package:marn/features/auth/data/models/auth_models.dart';

class AuthRepository {
  Future<AuthSession> submitPhone(String phoneNumber) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AuthSession(
      userId: 'user-${phoneNumber.replaceAll(RegExp(r'\\D'), '')}',
      phoneNumber: phoneNumber,
      isNewUser: false,
    );
  }

  Future<AuthSession> register(RegisterAccountDraft draft) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AuthSession(
      userId: 'new-${draft.phoneNumber.replaceAll(RegExp(r'\\D'), '')}',
      phoneNumber: draft.phoneNumber,
      isNewUser: true,
    );
  }

  Future<bool> verifyOtp(String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return code.trim().length >= 4;
  }
}
