import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_generator/ApiServices/zen_qr_bloc.dart';
import 'package:qr_code_generator/Utils/AppColors.dart';
import 'package:qr_code_generator/Utils/FFontStyles.dart';
import 'package:qr_code_generator/Utils/ImageAssets.dart';
import 'package:qr_code_generator/Widgets/CustomSnackbar.dart';
import 'package:qr_code_generator/Widgets/CustomTextField.dart';
import 'package:qr_code_generator/Widgets/custom_drawer.dart';
import 'dart:typed_data';
import 'package:mime/mime.dart';
import 'package:qr_code_generator/Widgets/file_saver.dart'; // Add this import
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _urlController = TextEditingController();
  File? _selectedImage;
  bool _loading = false;
  Uint8List? _qrImageBytes;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 80,
      );

      if (image != null) {
        final file = File(image.path);
        final size = await file.length();

        // Validate image size (max 2MB)
        if (size > 2 * 1024 * 1024) {
          CustomSnackbar.show(
            context,
            message: 'Image too large (max 2MB)',
            isSuccess: false,
          );
          return;
        }

        // Validate image type
        final mimeType = lookupMimeType(image.path);
        if (mimeType == null || !mimeType.startsWith('image/')) {
          CustomSnackbar.show(
            context,
            message: 'Invalid image format',
            isSuccess: false,
          );
          return;
        }

        setState(() => _selectedImage = file);
      }
    } catch (e) {
      CustomSnackbar.show(
        context,
        message: 'Failed to pick image: ${e.toString()}',
        isSuccess: false,
      );
    }
  }


  void _generateQR() {
    final url = _urlController.text.trim();

    // Better URL validation
    try {
      final uri = Uri.parse(url);
      if (!uri.hasAbsolutePath || uri.scheme.isEmpty) {
        throw FormatException('Invalid URL');
      }
    } catch (e) {
      CustomSnackbar.show(context,
          message: 'Please enter a valid URL (e.g., https://example.com)',
          isSuccess: false
      );
      return;
    }

    if (_loading) return;

    context.read<QRevixBloc>().add(
      QRevixEventHandler(url: url, image: _selectedImage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      body: BlocListener<QRevixBloc, QRevixState>(
        listener: (context, state) {
          if (state is QRevixLoading) {
            setState(() => _loading = true);
          } else if (state is QRevixSuccess) {
            developer.log('success: ${state.message}');
            setState(() {
              _loading = false;
              _qrImageBytes = state.qrImageBytes;
              _urlController.clear();
              _selectedImage = null;
            });
            CustomSnackbar.show(context, message: state.message, isSuccess: true);
          } else if (state is QRevixError) {
            developer.log('error: ${state.message}');
            setState(() => _loading = false);
            CustomSnackbar.show(context, message: state.message, isSuccess: false);
          }
        },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ImageAssets.appIconHome, height: height * 0.1),
              SizedBox(height: height * 0.01),
              Text('Generate Your QR Code', style: CustomTextStyles.heading(context)),
              SizedBox(height: height * 0.025),

              CustomTextField(
                controller: _urlController,
                hintText: 'Enter URL (e.g., https://example.com)',
              ),

              SizedBox(height: height * 0.02),

              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image_outlined),
                    label: const Text('Add Image'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.01),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.mobilenumber,
                      foregroundColor: Colors.white,
                      elevation: 3,
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (_selectedImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _selectedImage!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),

              SizedBox(height: height * 0.035),

              ElevatedButton.icon(
                onPressed: _loading ? null : _generateQR,
                icon: _loading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
                    : const FaIcon(FontAwesomeIcons.qrcode, size: 20, color: Colors.white),
                label: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: width * 0.01),
                  child: Text(
                    _loading ? 'Generating...' : 'Generate QR',
                    style: CustomTextStyles.button(context).copyWith(color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 5,
                ),
              ),

              SizedBox(height: height * 0.05),

              if (_qrImageBytes != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.01),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyText),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text("Your QR Code", style: CustomTextStyles.subheading(context)),
                      SizedBox(height: height * 0.015),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.memory(
                          _qrImageBytes!,
                          height: 220,
                          width: 220,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.error, size: 64, color: Colors.red),
                        ),
                      ),

                      // Add spacing
                      SizedBox(height: height * 0.025),

                      // Add Save button here
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_qrImageBytes != null) {
                            FileSaver.saveFile(
                              context: context,
                              bytes: _qrImageBytes!,
                              fileName: 'qr_code_${DateTime.now().millisecondsSinceEpoch}.png',
                            );
                          }
                        },
                        icon: const Icon(Icons.download_rounded, color: Colors.white),
                        label: Text(
                          "Save QR Code",
                          style: CustomTextStyles.button(context)
                              .copyWith(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),

            ],
          ),
        ),
      ),
    ),
    );
  }
}