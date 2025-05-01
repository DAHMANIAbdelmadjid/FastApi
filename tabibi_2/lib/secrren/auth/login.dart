import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/providers/auth_provider.dart';
import 'package:tabibi_2/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSize.s20),
                  Center(
                    child: Text(
                      "Sign In",
                      style: const TextStyle(
                        fontSize: FontSize.s22,
                        fontWeight: FontWeightManger.semiBold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s40),
                  CustomTextField(
                    text: "Email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSize.s16),
                  CustomTextField(
                    text: "Password",
                    controller: _passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSize.s16),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                          context.read<AuthProvider>().setRememberMe(_rememberMe);
                        },
                      ),
                      const Text('Remember Me'),
                    ],
                  ),
                  const SizedBox(height: AppSize.s20),
                  Consumer<AuthProvider>(
                    builder: (context, auth, _) {
                      if (auth.error != null) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSize.s16),
                          child: Text(
                            auth.error!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text("Sign In"),
                  ),
                  const SizedBox(height: AppSize.s20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Or Sign In with"),
                      const SizedBox(width: AppSize.s16),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     FontAwesomeIcons.facebook,
                      //     color: Colors.blue,
                      //   ),
                      // ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signUp');
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeightManger.semiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      final success = await authProvider.login(
        _emailController.text,
        _passwordController.text,
      );

      if (success && mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rememberMe = context.read<AuthProvider>().rememberMe;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
