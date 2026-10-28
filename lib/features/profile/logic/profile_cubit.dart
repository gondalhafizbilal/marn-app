import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/profile/data/models/profile_models.dart';
import 'package:marn/features/profile/data/repositories/profile_repository.dart';

enum ProfileStatus { loading, loaded }

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.loading,
    this.profile,
    this.ads = const [],
    this.payments = const [],
  });

  final ProfileStatus status;
  final ProfileSummary? profile;
  final List<UserAd> ads;
  final List<PaymentRecord> payments;

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileSummary? profile,
    List<UserAd>? ads,
    List<PaymentRecord>? payments,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      ads: ads ?? this.ads,
      payments: payments ?? this.payments,
    );
  }

  @override
  List<Object?> get props => [status, profile, ads, payments];
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.repository}) : super(const ProfileState());

  final ProfileRepository repository;

  Future<void> loadProfile() async {
    final profile = await repository.getProfile();
    emit(state.copyWith(status: ProfileStatus.loaded, profile: profile));
  }

  Future<void> loadAds() async {
    final ads = await repository.getAds();
    emit(state.copyWith(status: ProfileStatus.loaded, ads: ads));
  }

  Future<void> loadPayments() async {
    final payments = await repository.getPaymentHistory();
    emit(state.copyWith(status: ProfileStatus.loaded, payments: payments));
  }
}
