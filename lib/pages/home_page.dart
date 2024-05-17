import 'dart:math';

import 'package:english_card/models/english_today.dart';
import 'package:english_card/packages/quote/qoute_model.dart';
import 'package:english_card/pages/all_words_page.dart';
import 'package:english_card/pages/control_page.dart';
import 'package:english_card/values/app_assets.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:english_card/values/share_keys.dart';
import 'package:english_card/widgets/app_botton.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../packages/quote/quote.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishToday> words = [];

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.counter) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: len, max: nouns.length);
    rans.forEach((element) {
      newList.add(nouns[element]);
    });
    setState(() {
      words = newList.map((e) => getQuote(e)).toList();
    });
  }

  EnglishToday getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(
      noun: noun,
      quote: quote?.content,
      id: quote?.id,
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text(
          'English today',
          style: AppStyles.h4.copyWith(color: AppColors.textColor),
        ),
        centerTitle: true, // Đặt tiêu đề giữa trung tâm
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
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
              // color: Colors.red,
              child: PageView.builder(
                controller: _pageController,
                // onPageChanged: (index) => setState(() => _currentIndex = index),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: words.length,

                itemBuilder: (context, index) {
                  String firstLetter = words[index].noun != null
                      ? words[index].noun!.toUpperCase()
                      : '';
                  firstLetter = firstLetter.substring(0, 1);
                  String leftLetter = words[index].noun != null
                      ? words[index].noun!.substring(1)
                      : '';

                  String quoteDefault =
                      '"Think of all the beauty still left around you and be happy"';
                  String quote = words[index].quote != null
                      ? words[index].quote!
                      : quoteDefault;

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        // them stack de viet so trang , bo stack thi xoa di la dc,
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
                                    text: firstLetter,
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
                                        text: leftLetter,
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
                                    child: RichText(
                                      maxLines: 7,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: "$quote",
                                        style: AppStyles.h4.copyWith(
                                          letterSpacing: 1,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                '${_currentIndex + 1}/${words.length}',
                                style: AppStyles.h5.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ));
                },
              ),
            ),
            _currentIndex >= 5
                ? buildShowMore()
                : SizedBox(
                    height: size.height * 1 / 11,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return buildIndicator(
                              index == _currentIndex, size, index);
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
          setState(() {
            getEnglishToday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.lighBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16),
                child: Text(
                  'Your mind',
                  style: AppStyles.h3.copyWith(color: AppColors.textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: AppButton(
                    label: 'Favorites',
                    onTap: () {
                      print('Favorites');
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: AppButton(
                    label: 'Your Control',
                    onTap: () {
                      print('Your Control');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ControlPage()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
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

  Widget buildShowMore() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        alignment: Alignment.centerLeft,
        // color: AppColors.primaryColor,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          elevation: 4,
          color: AppColors.primaryColor,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AllWordsPage(words: words)));
            },
            borderRadius: BorderRadius.all(Radius.circular(24)),
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  'Show more',
                  style: AppStyles.h5.copyWith(color: AppColors.textColor),
                )),
          ),
        ));
  }
}
