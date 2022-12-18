import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:travely_admin/app/common/color_values.dart';
import 'package:travely_admin/app/common/shared_code.dart';
import 'package:travely_admin/app/repositories/auth/auth_repository.dart';
import 'package:travely_admin/app/routes/router.gr.dart';
import 'package:travely_admin/app/widgets/custom_text_field.dart';

import '../../cubits/cubits.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(AuthRepository()),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Container(
                      width: 100.w,
                      color: ColorValues.lightBlue,
                      height: 50.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Image.asset('assets/login-asset.png'),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 49.h),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          padding:
                              const EdgeInsets.all(SharedCode.defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(height: 1.h),
                              const Text(
                                  'Masuk dengan akunmu untuk melanjutkan.'),
                              SizedBox(height: 2.5.h),
                              CustomTextField(
                                labelText: 'Email',
                                hintText: 'Masukkan email',
                                controller: _emailController,
                                textInputType: TextInputType.emailAddress,
                                validator: SharedCode().emailValidator,
                              ),
                              SizedBox(height: 2.h),
                              CustomTextField(
                                labelText: 'Password',
                                hintText: 'Masukkan password',
                                controller: _passwordController,
                                isPassword: true,
                                maxLines: 1,
                                validator: SharedCode().passwordValidator,
                              ),
                              SizedBox(height: 3.h),
                              ElevatedButton(
                                  onPressed: () {
                                    _buttonPressed(context);
                                  },
                                  child: const Text('Masuk')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _buttonPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().emailChanged(_emailController.text);
      context.read<LoginCubit>().passwordChanged(_passwordController.text);
      context.loaderOverlay.show();
      try {
        await context.read<LoginCubit>().login(context);
        Future.delayed(const Duration(seconds: 2)).then((_) {
          SharedCode().handleAuthenticationRouting(context: context);
        });
      } catch (e) {
        SharedCode.showErrorDialog(context, 'Error', e.toString());
        context.loaderOverlay.hide();
      }
    }
  }
}
