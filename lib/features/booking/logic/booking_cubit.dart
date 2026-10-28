import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/booking/data/models/booking_models.dart';
import 'package:marn/features/booking/data/repositories/booking_repository.dart';

class BookingState extends Equatable {
  const BookingState({this.quote});

  final BookingQuote? quote;

  @override
  List<Object?> get props => [quote];
}

class BookingCubit extends Cubit<BookingState> {
  BookingCubit({required this.repository}) : super(const BookingState());

  final BookingRepository repository;

  Future<void> load() async {
    emit(BookingState(quote: await repository.getQuote()));
  }
}
