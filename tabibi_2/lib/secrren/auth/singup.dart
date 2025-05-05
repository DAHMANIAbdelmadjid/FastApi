import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/app/providers/auth_provider.dart';
import 'package:tabibi_2/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();

      await authProvider.signup(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (!mounted) return;

      if (authProvider.state.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.state.error!),
            backgroundColor: Colors.red,
          ),
        );
      } else if (authProvider.state.loginResponse?.succeeded == true && 
                 authProvider.state.loginResponse?.data!= null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sign up successful"),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to patient registration with required data
        Navigator.pushReplacementNamed(
          context,
          '/patient-registration',
          arguments: {
            'userId': authProvider.state.loginResponse!.data!,
            'email': _emailController.text,
            'fullName': _nameController.text,
          },
        );
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
                      "Welcome",
                      style: getBoldStyle(
                        fontSize: FontSize.s22,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s40),
                  Text(
                    "Sign Up",
                    style: getBoldStyle(
                      fontSize: FontSize.s26,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
                  Text(
                    "Create a new account",
                    style: getRegularStyle(
                      fontSize: FontSize.s18,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: AppSize.s24),
                  CustomTextField(
                    text: "Full Name",
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSize.s16),
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
                  const SizedBox(height: AppSize.s24),
                  Consumer<AuthProvider>(
                    builder: (context, auth, _) {
                      return ElevatedButton(
                        onPressed: auth.state.isLoading ? null : _handleSignUp,
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
                                "Sign Up",
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
                        "Or Sign Up with",
                        style: getRegularStyle(
                          fontSize: FontSize.s14,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(width: AppSize.s16),
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
                      Text(
                        "Already have an account?",
                        style: getRegularStyle(
                          fontSize: FontSize.s14,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          "Sign In",
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
    _nameController.dispose();
    super.dispose();
  }
}
