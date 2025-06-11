part of 'zen_qr_bloc.dart';

@immutable
sealed class QRevixEvent {}

class QRevixEventHandler extends QRevixEvent {
  final String url;
  final File? image;
  QRevixEventHandler({required this.url, this.image});
}