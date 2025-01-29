import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _checkPwController = TextEditingController();
  final Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
  });

  void register(BuildContext context){
    final auth = AuthService();
    final email = _emailController.text;
    final password = _pwController.text;
    final checkPassword = _checkPwController.text;

    if (password == checkPassword) {
      try{
        auth.signUpWhithEmailPassowrd(email, password);
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
    }else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords do not match"),
          content: Text("Please check your password"),
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
              "Let's create an account for you!",
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

            const SizedBox(height: 12),

            MyTextField(
              hintText: "Confirm Password",
              icon: Icons.password,
              controller: _checkPwController,
              obscureText: true,
              focusNode: null,
              helperText: "Minimum 6 characters",
            ),

            const SizedBox(height: 25),

            MyButton(
              text: "Register", 
              onTap: () => register(context)
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login",
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