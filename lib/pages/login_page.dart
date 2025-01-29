import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final Function()? onTap;

  LoginPage({
    super.key,
    required this.onTap,
  });

  void login(BuildContext context) async{
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text,
        _pwController.text
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        )
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Icon(
              Icons.message, 
              size: 60, 
              color: Theme.of(context).colorScheme.primary
            ),

            const SizedBox(height: 50),

            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 25),

            MyTextField(
              hintText: "Email",
              icon: Icons.email,
              controller: _emailController,
              obscureText: false,
              focusNode: null,
              helperText: "example@example.it",
            ),

            const SizedBox(height: 12),

            MyTextField(
              hintText: "Password",
              icon: Icons.password,
              controller: _pwController,
              obscureText: true,
              focusNode: null,
              helperText: "Minimum 6 characters",
            ),

            const SizedBox(height: 27),

            MyButton(
              text: "Login", 
              onTap: () => login(context),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}