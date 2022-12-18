import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travely_admin/app/common/shared_code.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil'),),
      body: Padding(
        padding: const EdgeInsets.all(SharedCode.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              context.loaderOverlay.show();
              SharedCode().handleAuthenticationRouting(context: context, isLogout: true);
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
