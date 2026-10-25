import 'package:flutter/material.dart';
import 'package:trivia_app/pages/home.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "images/gettyimages-1428792471-640x640.jpg",
              fit: BoxFit
                  .cover, // 💡 نصيحة مكملة: أضف هذا السطر لملء الخلفية بالكامل بدون مساحات بيضاء
            ),
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Image.asset(
                "images/trivia-night-vector-stylized-colorful-font-trivia-night-vector-illustration-letters-banner-colorful-badge-illustration-white-134375578.webp",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 120.0),
                    height: 60,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // 💡 تدوير الحواف ليصبح زر دائري احترافي
                    ),
                    child: const Center(
                      child: Text(
                        "Start Playing",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
