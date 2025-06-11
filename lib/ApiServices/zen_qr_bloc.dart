import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
part 'zen_qr_event.dart';
part 'zen_qr_state.dart';

class QRevixBloc extends Bloc<QRevixEvent, QRevixState> {
  QRevixBloc() : super(QRevixInitial()) {
    on<QRevixEventHandler>((event, emit) async {
      emit(QRevixLoading());
      try {
        // Prepare the base body
        final body = {
          'text': event.url,
          'width': 150,
          'height': 150,
          'qrOptions': {'errorCorrectionLevel': 'M'},
          'imageOptions': {
            'hideBackgroundDots': true,
            'margin': 2,
          },
          'dotsOptions': {
            'color': 'black',
            'type': 'square',
          },
          'backgroundOptions': {
            'color': 'white',
          },
          'cornersSquareOptions': {
            'color': 'black',
            'type': 'square',
          },
          'cornersDotOptions': {
            'color': 'black',
            'type': 'square',
          }
        };

        // Handle image if provided
        if (event.image != null) {
          final bytes = await event.image!.readAsBytes();
          final mimeType = lookupMimeType(event.image!.path) ?? 'image/png';
          final base64Image = base64Encode(bytes);
          body['logo'] = 'data:$mimeType;base64,$base64Image';
        }

        final response = await http.post(
          Uri.parse('https://apihut.in/api/qrcode'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'X-Avatar-Key': '454739b9-415f-493f-bc7c-e64f62bf1f13',
          },
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          if (response.headers['content-type']?.contains('image/') ?? false) {
            emit(QRevixSuccess('QR code generated', response.bodyBytes));
          } else {
            // Try to parse as JSON for error message
            final jsonResponse = jsonDecode(response.body);
            emit(QRevixError(jsonResponse['message'] ?? 'Invalid response format'));
          }
        } else {
          final errorResponse = jsonDecode(response.body);
          emit(QRevixError(errorResponse['message'] ?? 'API request failed'));
        }
      } catch (e) {
        emit(QRevixError('Failed to generate QR code: ${e.toString()}'));
      }
    });
  }
}