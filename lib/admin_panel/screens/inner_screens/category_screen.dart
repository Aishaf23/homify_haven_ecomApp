
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/model/category_model.dart';
import 'package:sizer/sizer.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'ALL CATEGORIES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26, // Adjusted sp for text sizing
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          iconSize: 20, // Adjusted sp for icon sizing
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          child: Column(
            children: [
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Total Categories',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 0.5.h), // Adjusted h for spacing
                      Text(
                        '${categories.length}',
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      // contentPadding: EdgeInsets.symmetric(
                      //   vertical: 1.h, // Adjusted h for padding
                      //   horizontal: 4.w, // Adjusted w for padding
                      // ),
                      onTap: () {
                        // Handle category selection
                        if (kDebugMode) {
                          print('Selected category: ${categories[index].title}');
                        }
                      },
                      leading: Image.asset(
                        categories[index].image!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        categories[index].title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20, // Adjusted sp for text sizing
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
