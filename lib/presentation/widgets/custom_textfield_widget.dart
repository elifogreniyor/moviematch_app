import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sinflix/core/constants/app_constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String iconPath;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.iconPath,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.obscureText;
    return SizedBox(
      height: AppConstants.textFieldHeight,
      child: TextField(
        controller: widget.controller,
        obscureText: isPassword ? _obscured : false,
        style: const TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: AppConstants.textFieldFontSize,
          color: AppColors.white50,
          fontWeight: FontWeight.w400,
          height: 1.5, // 18/12
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white10,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontSize: AppConstants.textFieldFontSize,
            color: AppColors.white50,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: AppConstants.prefixIconLeft,
              right: AppConstants.prefixIconRight,
            ),
            child: SvgPicture.asset(
              widget.iconPath,
              width: AppConstants.prefixIconWidth,
              height: AppConstants.prefixIconHeight,
              color: AppColors.white,
            ),
          ),
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () => setState(() => _obscured = !_obscured),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18, left: 12),
                    child: SvgPicture.asset(
                      _obscured
                          ? "assets/icons/eye.svg"
                          : "assets/icons/eye_off.svg",
                      width: AppConstants.iconSize,
                      height: AppConstants.iconSize,
                      color: AppColors.white,
                    ),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: const BorderSide(
              color: AppColors.textFieldBorder,
              width: AppConstants.borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: const BorderSide(
              color: AppColors.textFieldBorder,
              width: AppConstants.borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: const BorderSide(
              color: AppColors.textFieldBorderFocused,
              width: AppConstants.borderWidth,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 0),
        ),
      ),
    );
  }
}
