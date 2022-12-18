import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../common/shared_code.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;

  @override
  void initState() {
    _user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Container(
        padding: const EdgeInsets.all(SharedCode.defaultPadding),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_user?.displayName ?? '', style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 14.sp),),
            Text(_user?.email ?? ''),
            const Spacer(),
            ElevatedButton(onPressed: () {
              SharedCode.showAlertDialog(context, 'Konfirmasi', 'Apakah kamu yakin ingin keluar?', () {
                context.loaderOverlay.show();
                SharedCode().handleAuthenticationRouting(context: context, isLogout: true);
              });
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
