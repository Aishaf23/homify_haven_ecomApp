import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.060,
            ),
            Container(
              height: height * 0.8,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                border: const Border(
                  left: BorderSide(width: 0.1),
                  right: BorderSide(width: 0.1),
                  top: BorderSide(width: 0.1),
                  bottom: BorderSide(width: 0.1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.015,
                  ),
                  const Text(
                    'Ratings & Reviews',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.star_border_rounded)),
                      const Text('4.5'),
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        // label: Text('Write a Review'),
                        hintText: 'Write a Review'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
