import 'package:flutter/material.dart';
import '../../../model/user_model.dart';
import '../../../services/user_services.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<UserModel>> _usersFuture;
  late Future<int> _userCountFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = UserService().fetchUsers();
    _userCountFuture = UserService().fetchUsers().then((users) => users.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Users List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
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
          iconSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: FutureBuilder<int>(
                  future: _userCountFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('No users found'));
                    }

                    int userCount = snapshot.data!;

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Total Users',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '$userCount',
                              style: const TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<UserModel>>(
                future: _usersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No users found'));
                  }

                  List<UserModel> users = snapshot.data!;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                'User ID',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Name',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Email',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                          rows: users.map((user) {
                            return DataRow(cells: [
                              DataCell(
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: user.uId.length > 8
                                            ? user.uId.substring(0, 8)
                                            : user.uId,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (user.uId.length > 8)
                                        const TextSpan(
                                          text: ".....",
                                          style: TextStyle(
                                            color:
                                                Colors.white54, 
                                          ),
                                        ),
                                    ],
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.username,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.email,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ]);
                          }).toList(),
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
