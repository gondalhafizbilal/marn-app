class ApiErrorModel {
  const ApiErrorModel({required this.message, this.statusCode});

  final String message;
  final int? statusCode;
}
