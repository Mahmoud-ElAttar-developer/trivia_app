import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService {
  // مفتاح الأمان الخاص بك المأخوذ من سكرين شوت الخدمة
  static const String apiKey = "h1yhPBCTiH4xrD2hq6Wx1c79TKqpX3WB1W3I8ZPQ";

  // دالة ذكية واحدة تجلب السؤال والإجابة الصحيحة و3 كلمات عشوائية خاطئة وتدمجهم معاً
  static Future<Map<String, dynamic>?> getCompleteQuiz(String category) async {
    try {
      // 1. طلب جلب السؤال والإجابة الصحيحة
      final triviaResponse = await http.get(
        Uri.parse('https://api.api-ninjas.com/v1/trivia'),
        headers: {'X-Api-Key': apiKey},
      );

      if (triviaResponse.statusCode == 200) {
        List<dynamic> triviaData = jsonDecode(triviaResponse.body);
        if (triviaData.isNotEmpty) {
          String question = triviaData[0]['question'];
          String correctAnswer = triviaData[0]['answer'];

          // 2. طلب جلب 3 كلمات عشوائية لاستخدامها كخيارات خاطئة
          final wordResponse = await http.get(
            Uri.parse('https://api.api-ninjas.com/v1/triviaoftheday?amount=4'),
            headers: {'X-Api-Key': apiKey},
          );

          List<String> options = [correctAnswer]; // إضافة الجواب الصحيح كأول عنصر

          if (wordResponse.statusCode == 200) {
            List<dynamic> wordData = jsonDecode(wordResponse.body);
            for (var item in wordData) {
              options.add(item.toString());
            }
          }

          // حماية احتياطية في حال تعثر إنترنت جلب الكلمات العشوائية
          while (options.length < 4) {
            options.add("Alternative ${options.length}");
          }

          // خلط ترتيب قائمة الاختيارات عشوائياً حتى لا تظهر الإجابة الصحيحة دائماً في نفس الزر
          options.shuffle();

          // إرجاع خريطة البيانات النهائية الجاهزة للشاشة
          return {
            'question': question,
            'answer': correctAnswer,
            'options': options,
          };
        }
      }
    } catch (e) {
      print("Error in QuizService: $e");
    }
    return null;
  }
}
