part of 'zen_qr_bloc.dart';

@immutable
sealed class QRevixState {}

final class QRevixInitial extends QRevixState {}

class QRevixLoading extends QRevixState {}

class QRevixSuccess extends QRevixState {
  final String message;
  final Uint8List qrImageBytes;
  QRevixSuccess(this.message, this.qrImageBytes);
}

class QRevixError extends QRevixState {
  final String message;
  QRevixError(this.message);
}