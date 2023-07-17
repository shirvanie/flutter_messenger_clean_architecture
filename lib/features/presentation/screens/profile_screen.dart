
import 'package:flutter/material.dart';
import 'package:messenger/features/data/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Text("The user profile can be found here", style: TextStyle(color: Theme.of(context).colorScheme.primary),)
      ),
    );
  }
}
