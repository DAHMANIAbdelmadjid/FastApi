import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
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
  void initState() {
    super.initState();
    _initRememberMe();
  }

  void _initRememberMe() {
    final auth = context.read<AuthProvider>();
    _rememberMe = auth.rememberMe;
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final auth = context.read<AuthProvider>();

      auth.setRememberMe(_rememberMe);
      await auth.login(
        _emailController.text,
        _passwordController.text,
      );

      if (!mounted) return;

      if (auth.state.error != null) {
        // Show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(auth.state.error!),
            backgroundColor: Colors.red,
          ),
        );
      } else if (auth.state.loginResponse?.succeeded == true) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

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
                      "Welcome Back",
                      style: getBoldStyle(
                        fontSize: FontSize.s22,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s40),
                  Text(
                    "Login",
                    style: getBoldStyle(
                      fontSize: FontSize.s26,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
                  Text(
                    "Please sign in to continue",
                    style: getRegularStyle(
                      fontSize: FontSize.s18,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: AppSize.s24),
                  CustomTextField(
                    text: "Email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
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
                        return "Please enter your password";
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
                        },
                      ),
                      Text(
                        "Remember me",
                        style: getRegularStyle(
                          fontSize: FontSize.s14,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s24),
                  Consumer<AuthProvider>(
                    builder: (context, auth, child) {
                      return ElevatedButton(
                        onPressed: auth.state.isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: auth.state.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Login",
                                style: getBoldStyle(
                                  fontSize: FontSize.s16,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.s20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: getRegularStyle(
                          fontSize: FontSize.s14,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signUp');
                        },
                        child: Text(
                          "Sign Up",
                          style: getBoldStyle(
                            fontSize: FontSize.s14,
                            color: AppColors.primaryColor,
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
