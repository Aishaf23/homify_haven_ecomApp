import 'package:flutter/material.dart';
import 'package:homify_haven/menu_bottom_bar/home_page.dart';
import 'package:homify_haven/menu_page.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isPasswordHidden1 = false;
  bool isPasswordHidden2 = false;
  bool isPasswordHidden3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: isPasswordHidden1,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    label: Text('Current Password'),
                    hintText: 'Enter current password',
                    labelStyle: TextStyle(color: Colors.black),
                    helperText:
                        "Password must be at least 6 characters or more",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    suffixIcon: IconButton(
                      icon: Icon(isPasswordHidden1
                          ? Icons.visibility_off
                          : Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          isPasswordHidden1 = !isPasswordHidden1;
                        });
                      },
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                obscureText: isPasswordHidden2,
                decoration: InputDecoration(
                  label: Text('New Password'),
                  hintText: 'Enter new password',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1.5, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1.5, color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordHidden2
                        ? Icons.visibility_off
                        : Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden2 = !isPasswordHidden2;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: isPasswordHidden3,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  label: Text('New Password Again'),
                  hintText: 'Enter new password again',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1.5, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1.5, color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordHidden3
                        ? Icons.visibility_off
                        : Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden3 = !isPasswordHidden3;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password Changed Successfully')));
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return MainMenu();
                  }));
                },
                child: Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, minimumSize: Size(100, 60)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
