import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final XFile? pickedImage;
  final Function function;

  const ImagePickerWidget({
    super.key,
    required this.pickedImage,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: pickedImage == null
                ? Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'No Image \nSelected',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : Image.file(
                    File(pickedImage!.path),
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            color: Colors.blueGrey.shade300,
            child: InkWell(
              splashColor: Colors.red,
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                function();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
