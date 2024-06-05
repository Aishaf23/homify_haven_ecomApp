import 'package:flutter/material.dart';

class MyAppMethods {
  static Future<void> showErrorOrWarningDialog({
    required BuildContext context,
    required String errortext,
    required VoidCallback onPress, // Changed Function to VoidCallback
    bool isError = true,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize:
                  MainAxisSize.min, // Add this line to constrain column size
              children: [
                Icon(
                  Icons.warning,
                  size: 17,
                ),
                SizedBox(
                  height: 13,
                ),
                Text(
                  errortext,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Add this line for better alignment
                  children: [
                    Visibility(
                      visible: !isError,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: onPress, // Pass the function as a callback
                      child: Text(
                        "OK",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Choose Option')),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      cameraFCT();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    label: Text(
                      'Camera',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    icon: GradientIcon(
                      icon: Icons.camera,
                      size: 30,
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.red,
                          Colors.green,
                          Colors.yellow,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      galleryFCT();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    label: Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    icon: Icon(
                      Icons.image,
                      color: Colors.purple.shade800,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      removeFCT();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    label: Text(
                      'Remove',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    icon: Icon(
                      Icons.remove,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Gradient gradient;

  const GradientIcon({
    super.key,
    required this.icon,
    required this.size,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Icon(
        icon,
        size: size,
        color: Colors
            .white, // The color should be set to white to apply the gradient
      ),
    );
  }
}
