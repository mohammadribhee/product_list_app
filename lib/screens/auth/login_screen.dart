import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/constants/app_colors.dart';
import 'package:product_list_app/helper/getFriendlyAuthError.dart';
import 'package:product_list_app/widgets/custom_text_field.dart';
import 'package:product_list_app/widgets/primary_button.dart';
import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/auth/auth_state.dart';
import '../products/product_list_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool isRegister;

  LoginScreen({this.isRegister = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(title: Text(widget.isRegister ? 'Register' : 'Login')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => ProductListScreen()));
          } else if (state is AuthError) {
            final friendlyMessage = getFriendlyAuthError(state.message);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(friendlyMessage)));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 32),
                        Center(
                          child: Text(
                            widget.isRegister ? 'Register' : 'Login',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.whiteCard,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.border,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              CustomTextField(
                                hintText: 'E-mail',
                                controller: emailCtrl,
                                validator: (v) =>
                                    v!.contains('@') ? null : 'Invalid email',
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: 'Password',
                                controller: passCtrl,
                                obscureText: true,
                                validator: (v) =>
                                    v!.length < 6 ? 'Min 6 chars' : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        PrimaryButton(
                            label: widget.isRegister ? 'Register' : 'Login',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                widget.isRegister
                                    ? authCubit.register(
                                        emailCtrl.text, passCtrl.text)
                                    : authCubit.login(
                                        emailCtrl.text, passCtrl.text);
                              }
                            },
                            backgroundColor: AppColors.loginButton,
                            textColor: AppColors.whiteCard,
                            vertical: 16,
                            shape: 30,
                            fontSize: 20),

                        const SizedBox(
                            height: 32), // Replaced Spacer with SizedBox
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: widget.isRegister
                                  ? 'Already have an account? '
                                  : 'Don\'t have an account? ',
                              style: const TextStyle(color: Colors.black87),
                              children: [
                                TextSpan(
                                  text:
                                      widget.isRegister ? 'Login' : 'Register',
                                  style: const TextStyle(
                                    color: AppColors.peach,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => LoginScreen(
                                              isRegister: !widget.isRegister),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
