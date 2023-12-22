import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/screens/LoginAndSignUpScreen/loginScreen.dart';
import 'package:kisisel_hedef_asistani/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/background.png",
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(
                              2.0, 2.0), // X ve Y yönlü gölge offset değerleri
                          blurRadius: 3.0, // Gölge bulanıklık yarıçapı
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(188, 235, 0, 75),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildTextInputContainer(
                              controller: fullNameController,
                              text: "Full Name",
                              width: 0.8),
                          _buildTextInputContainer(
                              controller: eMailController,
                              text: "E-Mail",
                              width: 0.8),
                          _buildTextInputContainer(
                              controller: passwordController,
                              text: "Password",
                              width: 0.8),
                          _buildTextInputContainer(
                              controller: fullNameController,
                              text: "Confirm Password",
                              width: 0.8),
                          const SizedBox(height: 8),
                          //Sign Up Button
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 27, 133, 1)),
                              onPressed: () => AuthService().signUp(
                                  name: fullNameController.text,
                                  email: eMailController.text,
                                  password: passwordController.text),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>LoginScreen(),
                                ));
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextInputContainer({
    required TextEditingController controller,
    required String text,
    required double width,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 45,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
