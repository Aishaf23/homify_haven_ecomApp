import 'package:flutter/material.dart';
import 'package:homify_haven/menu_bottom_bar/profile/billing.dart';
import 'package:homify_haven/menu_bottom_bar/profile/change_password.dart';
import 'package:homify_haven/menu_bottom_bar/profile/edit_user_profile.dart';
import 'package:homify_haven/screens/order/order_history.dart';
import 'package:homify_haven/screens/inner%20screens/recently_view.dart';
import 'package:homify_haven/screens/inner%20screens/wish_list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: const Color(0xFF113d26),
          child: Column(children: [
            // // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text(
            //         'Profile',
            //         style: TextStyle(
            //           fontSize: 20,
            //           color: Colors.white,
            //         ),
            //       ),
            //       Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Colors.white,
            //           ),
            //           shape: BoxShape.circle,
            //         ),
            //         child: const CircleAvatar(
            //             backgroundColor: Colors.transparent,
            //             child: Icon(
            //               Icons.more_vert,
            //               color: Colors.white,
            //             )),
            //       )
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),

            SizedBox(
              height: 100,
            ),
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                radius: 60,
                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Center(
              child: Text(
                'Aisha Farooq',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                '+92 123 4567890',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              height: height * 0.53,
              width: double.infinity,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        top: 5,
                      ),
                      child: Text(
                        'Account Overview',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Container(
                      height: height * 0.35,
                      width: width * 1,
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.transparent,
                      ),
                      child: ListView(
                        children: [
                          MyListTile(
                            title: 'My Orders',
                            icon: Icons.list,
                            onPress: (_) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return OrderHistory();
                              }));
                            },
                            iconColor: const Color.fromARGB(255, 181, 173, 182),
                          ),
                          MyListTile(
                            title: 'Wishlist',
                            icon: Icons.person,
                            onPress: (context) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return WishListScreen();
                              }));
                            },
                            iconColor: const Color.fromARGB(255, 145, 78, 156),
                          ),
                          MyListTile(
                            title: 'Recently Viewed',
                            icon: Icons.shopping_cart,
                            onPress: (_) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return RecentlyViewScreen();
                              }));
                            },
                            iconColor: Colors.black,
                          ),
                          MyListTile(
                            title: 'Change Password',
                            icon: Icons.lock,
                            onPress: (_) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return ChangePassword();
                              }));
                            },
                            iconColor: Colors.blue,
                          ),
                          MyListTile(
                            title: 'Edit Profile',
                            icon: Icons.person,
                            onPress: (_) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return UserProfile();
                              }));
                            },
                            iconColor: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyListTile extends StatelessWidget {
  MyListTile(
      {required this.title,
      required this.icon,
      required this.onPress,
      required this.iconColor,
      super.key});

  String title;
  IconData icon;
  Function onPress;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      trailing: IconButton(
        onPressed: () => onPress(context),
        icon: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black54,
          size: 20,
        ),
      ),
    );
  }
}
