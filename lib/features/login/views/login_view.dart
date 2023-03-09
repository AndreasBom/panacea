import 'package:flutter/material.dart';
import 'package:panacea_app/features/admin/admin_home_view.dart';
import 'package:panacea_app/features/home/views/home_view.dart';

import '../../../utils/navigate.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 200,
          ),
          const Text(
            'Logga in',
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(
            height: 70,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                  width: 130,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigate.to(context, const AdminHomeView());
                      },
                      child: const Text('Admin'))),
              SizedBox(
                  width: 130,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigate.replace(context, const HomeView());
                      },
                      child: const Text('Användare'))),
            ],
          ),
        ],
      ),
    );
  }
}
