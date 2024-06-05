import 'package:flutter/material.dart';
import 'package:homify_haven/screens/order/address/add_address.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

List<String> options = ['Home', 'Work'];

class _ShippingAddressState extends State<ShippingAddress> {
  String currentOption = options[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop;
          },
        ),
        title: const Text(
          'Shipping Address',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            leading: Radio(
              groupValue: currentOption,
              value: options[0],
              activeColor: const Color.fromARGB(255, 36, 218, 175),
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              },
            ),
            title: const Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle:
                const Text('Jalil Abad Colony \nOpposite to UBL/HBL Bank \nMULTAN'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Radio(
              groupValue: currentOption,
              value: options[1],
              activeColor: const Color.fromARGB(255, 36, 218, 175),
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              },
            ),
            title: const Text(
              'Work',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('MaxCore Technologies \nSabzazar \nMULTAN'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddressAdd();
          }));
        },
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
        child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const Icon(Icons.add)),
      ),
    );
  }
}
