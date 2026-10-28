class AuthSession {
  const AuthSession({
    required this.userId,
    required this.phoneNumber,
    required this.isNewUser,
  });

  final String userId;
  final String phoneNumber;
  final bool isNewUser;
}

class RegisterAccountDraft {
  const RegisterAccountDraft({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
  });

  final String fullName;
  final String phoneNumber;
  final String email;
}
