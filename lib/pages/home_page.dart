import 'package:english_card/values/app_assets.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text(
          'English today',
          style: AppStyles.h4.copyWith(color: AppColors.textColor),
        ),
        centerTitle: true, // Đặt tiêu đề giữa trung tâm
        leading: InkWell(
          onTap: () {},
          child: Image.asset(AppAssets.menu),
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
                height: size.height * 1 / 9,
                // padding: const EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                child: Text(
                  '"It is amazing how complete is the delusion that beaty is gooodness"',
                  style: AppStyles.h5
                      .copyWith(fontSize: 12, color: AppColors.textColor),
                )),
            Container(
              height: size.height * 2 / 3,
              // padding: const EdgeInsets.all(16),
              color: Colors.red,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack( // them stack de viet so trang , bo stack thi xoa di la dc, 
                                    // xoa thu cong, khi xoa stack thi xoa ca Positioned
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(3, 6),
                                    blurRadius: 6)
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(AppAssets.heart),
                                ),
                                RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: 'B',
                                    style: TextStyle(
                                        fontFamily: FontFamily.sen,
                                        fontSize: 95,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(3, 6),
                                              blurRadius: 6)
                                        ]),
                                    children: [
                                      TextSpan(
                                        text: 'eatiful',
                                        style: TextStyle(
                                            fontFamily: FontFamily.sen,
                                            fontSize: 56,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(3, 6),
                                                  blurRadius: 6)
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    '"Think of all the beauty still left around you and be happy"',
                                    style: AppStyles.h4.copyWith(
                                      letterSpacing: 1,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                '${_currentIndex+1}/5',
                                style: AppStyles.h5.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                      // child: Container(
                      //   decoration: BoxDecoration(
                      //     color: AppColors.primaryColor,
                      //     borderRadius: BorderRadius.all(Radius.circular(24)),
                      //     boxShadow: [
                      //       BoxShadow(
                      //           color: Colors.black26,
                      //           offset: Offset(3, 6),
                      //           blurRadius: 6)
                      //     ],
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Container(
                      //         alignment: Alignment.centerRight,
                      //         child: Image.asset(AppAssets.heart),
                      //       ),
                      //       RichText(
                      //         maxLines: 1,
                      //         overflow: TextOverflow.ellipsis,
                      //         textAlign: TextAlign.start,
                      //         text: TextSpan(
                      //           text: 'B',
                      //           style: TextStyle(
                      //               fontFamily: FontFamily.sen,
                      //               fontSize: 95,
                      //               fontWeight: FontWeight.bold,
                      //               shadows: [
                      //                 BoxShadow(
                      //                     color: Colors.black38,
                      //                     offset: Offset(3, 6),
                      //                     blurRadius: 6)
                      //               ]),
                      //           children: [
                      //             TextSpan(
                      //               text: 'eatiful',
                      //               style: TextStyle(
                      //                   fontFamily: FontFamily.sen,
                      //                   fontSize: 56,
                      //                   fontWeight: FontWeight.bold,
                      //                   shadows: [
                      //                     BoxShadow(
                      //                         color: Colors.black38,
                      //                         offset: Offset(3, 6),
                      //                         blurRadius: 6)
                      //                   ]),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.all(8),
                      //         child: Text(
                      //           '"Think of all the beauty still left around you and be happy"',
                      //           style: AppStyles.h4.copyWith(
                      //               letterSpacing: 1, color: AppColors.textColor),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      );
                },
              ),
            ),
            SizedBox(
              height: size.height * 1 / 11,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return buildIndicator(index == _currentIndex, size, index);
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          print('exchange');
        },
        child: Image.asset(AppAssets.exchange),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size, int index) {
    return Container(
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
        color: isActive ? AppColors.lighBlue : AppColors.lightGrey,
        borderRadius: BorderRadius.all(Radius.circular(24)),
        boxShadow: [
          BoxShadow(color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
        ],
      ),
    );
  }
}
