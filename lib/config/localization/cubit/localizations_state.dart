import 'package:equatable/equatable.dart';

class LocalizationsState extends Equatable {
  const LocalizationsState(this.localeCode);

  final String localeCode;

  @override
  List<Object> get props => [localeCode];
}
