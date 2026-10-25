// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:trivia_app/pages/category_buttons.dart';
import 'package:trivia_app/pages/service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0; // متغير التحكم في الأزرار الموجود عندك مسبقاً

  // 👈 أعد كتابة هذه المتغيرات هنا لكي يتعرف عليها كود الأزرار المكتوب بالأسفل:
  String? question;
  String? answer;
  List<String> option = [];
  bool isLoading =
      false; // متغير لمعرفة حالة تحميل البيانات ومنع الشاشة البيضاء

  // 👈 دالة استدعاء الخدمة من ملف service وتحديث واجهة المستخدم
  Future<void> loadQuizData(String category) async {
    setState(() {
      isLoading = true;
    });

    var data = await QuizService.getCompleteQuiz(category);

    if (data != null) {
      setState(() {
        question = data['question'];
        answer = data['answer'];
        option = List<String>.from(data['options']);
      });
    } else {
      // 👈 الـ print بالإنجليزية هنا للكشف عن سبب المشكلة في الـ Console
      debugPrint(
        "Warning: API returned null. Check your APIKEY inside service.dart",
      );
    }

    // إيقاف التحميل دائماً لفتح الشاشة في كل الأحوال
    setState(() {
      isLoading = false;
    });
  }

  // 1. دالة جلب السؤال والإجابة الصحيحة من الـ API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? CircularProgressIndicator()
          : Stack(
              children: [
                // 1. صورة الخلفية كاملة الشاشة
                Positioned.fill(
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "images/gettyimages-1428792471-640x640.jpg",
                    fit: BoxFit.cover,
                  ),
                ),

                // 2. محتويات الصفحة فوق الخلفية
                Positioned.fill(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.only(top: 70.0, left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // حاوية برأس 50 بكسل تضمن تحديد مساحة الـ ListView الأفقية
                          SizedBox(
                            height: 50,
                            child: // 👈 ضع هذا السطر مكان كود الأزرار القديم بالكامل:
                            CategoryButtons(
                              selectedIndex: index,
                              onCategorySelected: (selectedId, apiName) {
                                setState(() {
                                  index =
                                      selectedId; // تحديث الزر النشط لتغيير لونه للبرتقالي
                                });
                                loadQuizData(
                                  apiName,
                                ); // استدعاء الـ API لجلب أسئلة القسم المختار فوراً
                              },
                            ),
                          ),
                          SizedBox(height: 50),
                          Container(
                            margin: const EdgeInsets.only(right: 20.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: answer == question ? Colors.green : Colors.white,
                              borderRadius: BorderRadius.circular(
                                20,
                              ), // تدوير حواف الكارت الأبيض ليصبح احترافياً
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(
                                    20.0,
                                  ), // إبعاد النص عن حواف الكارت الأبيض
                                  child: Column(
                                    children: [
                                      SizedBox(height: 50),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                            1.5,
                                        child: Text(
                                          question ?? "Loading Question...",
                                          style: TextStyle(
                                            color:  Colors.black,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          answer = option[0];
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        child: Container(
                                          height: 70,
                                          margin: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                          ),
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: answer == option[0] ? Colors.green : Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              option.isNotEmpty
                                                  ? option[0]
                                                  : "Loading...",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      GestureDetector(
                                        onTap: () {
                                          answer = option[1];
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        child: Container(
                                          height: 70,
                                          margin: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                          ),
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: answer == option[1] ? Colors.green : Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              option.length > 1
                                                  ? option[1]
                                                  : "Loading...",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      GestureDetector(
                                        onTap: () {
                                          answer = option[2];
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        child: Container(
                                          height: 70,
                                          margin: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                          ),
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              option.length > 2
                                                  ? option[2]
                                                  : "Loading...",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color:  Colors.black,
                                                fontSize: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      GestureDetector(
                                        onTap: () {
                                          answer = option[3];
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        child: Container(
                                          height: 70,
                                          margin: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                          ),
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              option.length > 3
                                                  ? option[3]
                                                  : "Loading...",
                                        
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
              ],
            ),
    );
  }
}
