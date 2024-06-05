import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  int selectedValue = 0;
  int selectedValue2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      //                   <--- right side
                      color: Color(0xff589B9A),
                      width: 5.0,
                    ),
                  ),
                ),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color.fromARGB(158, 183, 212, 230),
                    filled: true,
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(12))),
                    // enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Select payment'),
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text("JazzCash"),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text("Easypaisa"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Faisal Bank"),
                      value: 2,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Phone Number',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 55,
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    fillColor: Color.fromARGB(158, 183, 212, 230),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({super.key, required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
    );
  }
}
