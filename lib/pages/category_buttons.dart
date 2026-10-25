import 'package:flutter/material.dart';

class CategoryButtons extends StatelessWidget {
  final int selectedIndex;
  final Function(int, String) onCategorySelected;

  const CategoryButtons({
    super.key,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    // قائمة بأسماء الأقسام المعروضة والنصوص التي سيتم إرسالها للـ API
    final List<Map<String, dynamic>> categories = [
      {"name": "Music", "apiName": "music", "id": 1, "width": 120.0},
      {"name": "Geography", "apiName": "geography", "id": 2, "width": 170.0},
      {"name": "Food drink", "apiName": "foodanddrink", "id": 3, "width": 170.0},
      {"name": "Science nature", "apiName": "sciencenature", "id": 4, "width": 200.0},
      {"name": "Entertainment", "apiName": "entertainment", "id": 5, "width": 170.0},
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          bool isSelected = selectedIndex == category["id"];

          return GestureDetector(
            onTap: () {
              // إرسال رقم القسم المختار واسمه الصغير للـ API إلى ملف home.dart
              onCategorySelected(category["id"], category["apiName"]);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20.0),
              width: category["width"],
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  category["name"],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
