import 'package:english_card/models/english_today.dart';
import 'package:english_card/values/app_assets.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:flutter/material.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishToday> words;

  const AllWordsPage({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text(
          'English today',
          style: AppStyles.h4.copyWith(color: AppColors.textColor),
        ),
        centerTitle: true, // Đặt tiêu đề giữa trung tâm
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: words
              .map((e) => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration( 
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      e.noun ?? 'No data',
                      style: AppStyles.h5,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
