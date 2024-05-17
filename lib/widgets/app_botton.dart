


import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String label;
  final VoidCallback onTap;
  const AppButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 16
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(3, 6)
            )
          ]
        ),
        child: Text( 
          label,
          style: AppStyles.h5.copyWith(color: AppColors.textColor,)
        ),
      ),
    );
  }
}