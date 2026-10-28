import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/post_ad/data/models/post_ad_models.dart';
import 'package:marn/features/post_ad/data/repositories/post_ad_repository.dart';

class PostAdState extends Equatable {
  const PostAdState({
    this.category = 'Services',
    this.title = '',
    this.description = '',
    this.price = '',
    this.isSubmitting = false,
    this.isSubmitted = false,
  });

  final String category;
  final String title;
  final String description;
  final String price;
  final bool isSubmitting;
  final bool isSubmitted;

  PostAdState copyWith({
    String? category,
    String? title,
    String? description,
    String? price,
    bool? isSubmitting,
    bool? isSubmitted,
  }) {
    return PostAdState(
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [
    category,
    title,
    description,
    price,
    isSubmitting,
    isSubmitted,
  ];
}

class PostAdCubit extends Cubit<PostAdState> {
  PostAdCubit({required this.repository}) : super(const PostAdState());

  final PostAdRepository repository;

  void categoryChanged(String value) => emit(state.copyWith(category: value));

  void titleChanged(String value) => emit(state.copyWith(title: value));

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }

  void priceChanged(String value) => emit(state.copyWith(price: value));

  Future<void> submit() async {
    emit(state.copyWith(isSubmitting: true));
    await repository.submitDraft(
      PostAdDraft(
        category: state.category,
        title: state.title,
        description: state.description,
        price: state.price,
      ),
    );
    emit(state.copyWith(isSubmitting: false, isSubmitted: true));
  }
}
