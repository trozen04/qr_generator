import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_generator/Utils/AppColors.dart';
import 'package:qr_code_generator/Utils/FFontStyles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.textfieldborder
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonShadow.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Prefix Icon
          Container(
            width: width * 0.12,
            height: height * 0.055,
            alignment: Alignment.center,
            child: FaIcon(
              FontAwesomeIcons.link,
              color: AppColors.textPrimary,
              size: width * 0.06,
            ),
          ),
          // Text Input
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: height * 0.25,  // limit overall height
                  ),
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    expands: false,
                    style: CustomTextStyles.textFieldInput(context),
                    cursorColor: AppColors.textHighlight,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: CustomTextStyles.textFieldHint(context).copyWith(
                        color: controller.text.isEmpty ? AppColors.textPrimary.withOpacity(0.5) : Colors.transparent,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.02,
                        horizontal: width * 0.02,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}