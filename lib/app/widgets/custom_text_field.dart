import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../common/color_values.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final bool isPassword;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool readOnly;
  final Widget? prefixIcon;
  final int? minLines, maxLines;
  final double? paddingVertical;

  const CustomTextField(
      {Key? key,
      this.labelText,
      required this.hintText,
      required this.controller,
      this.isPassword = false,
      this.prefixIcon,
      this.textInputType = TextInputType.text,
      this.validator,
      this.readOnly = false,
      this.minLines,
      this.maxLines,
      this.paddingVertical})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) Text(widget.labelText!),
        if (widget.labelText != null) SizedBox(height: 1.h),
        TextFormField(
            obscureText: widget.isPassword && !_isShowPassword,
            keyboardType: widget.textInputType,
            controller: widget.controller,
            validator: widget.validator,
            readOnly: widget.readOnly,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            inputFormatters: widget.textInputType == TextInputType.number
                ? [ FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ]
                : null,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: widget.paddingVertical ?? 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: ColorValues.grey,
                  width: 1,
                ),
              ),
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _isShowPassword = !_isShowPassword;
                        });
                      },
                      child: Icon(
                        _isShowPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                  : null,
            )),
      ],
    );
  }
}
