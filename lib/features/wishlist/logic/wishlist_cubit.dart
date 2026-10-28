import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/home/data/models/home_models.dart';
import 'package:marn/features/wishlist/data/models/wishlist_item.dart';
import 'package:marn/features/wishlist/data/repositories/wishlist_repository.dart';

enum WishlistStatus { loading, loaded }

class WishlistState extends Equatable {
  const WishlistState({
    this.status = WishlistStatus.loading,
    this.items = const [],
    this.selected,
  });

  final WishlistStatus status;
  final List<WishlistItem> items;
  final WishlistItem? selected;

  WishlistState copyWith({
    WishlistStatus? status,
    List<WishlistItem>? items,
    WishlistItem? selected,
  }) {
    return WishlistState(
      status: status ?? this.status,
      items: items ?? this.items,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [status, items, selected];
}

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({required this.repository}) : super(const WishlistState());

  final WishlistRepository repository;
  StreamSubscription<List<WishlistItem>>? _wishlistSubscription;

  Future<void> load() async {
    final items = await repository.getWishlist();
    emit(state.copyWith(status: WishlistStatus.loaded, items: items));
    _wishlistSubscription ??= repository.watchWishlist().listen((items) {
      emit(state.copyWith(status: WishlistStatus.loaded, items: items));
    });
  }

  Future<void> loadItem(String id) async {
    final item = await repository.getWishlistItem(id);
    emit(state.copyWith(status: WishlistStatus.loaded, selected: item));
  }

  Future<void> saveProfile(MarketplaceListing listing) async {
    final item = await repository.saveProfile(listing);
    emit(
      state.copyWith(
        status: WishlistStatus.loaded,
        items: await repository.getWishlist(),
        selected: item,
      ),
    );
  }

  @override
  Future<void> close() {
    _wishlistSubscription?.cancel();
    return super.close();
  }
}
