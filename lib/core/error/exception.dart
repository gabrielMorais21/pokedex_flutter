class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
  List<Object> get props => [message];
}
