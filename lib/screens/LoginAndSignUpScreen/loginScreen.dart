import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(188, 235, 0, 75),
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          _buildTextInputContainer(
                              controller: emailController, text: "E-Mail"),
                          const SizedBox(height: 18),
                          _buildTextInputContainer(
                              controller: passwordController, text: "Password"),
                          const SizedBox(height: 18),
                          // Sign In Button
                          SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 27, 133, 1)),
                                onPressed: () {},
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                )),
                          ),
                          const Text(
                            "Or",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 18),
                          _buildSignButtons(
                              text: "Continue With Google",
                              images: "assets/images/google.png",
                              height: 30,
                              width: 30),
                          const SizedBox(height: 18),
                          _buildSignButtons(
                              text: "Continue With Facebook",
                              images: "assets/images/apple.png",
                              width: 30,
                              height: 30),
                          const SizedBox(height: 18),
                          _buildSignButtons(
                              text: "Continue With X",
                              images: "assets/images/x.png",
                              width: 30,
                              height: 20),
                          const SizedBox(height: 18),
                          TextButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Text(
                                    "Don't you have an account?",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Text(
                                    "Forget Your Password?",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInputContainer(
      {required TextEditingController controller, required String text}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
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
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignButtons(
      {required double width,
      required double height,
      required String text,
      required String images}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 45,
      child: ElevatedButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                images,
                width: width,
                height: height,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                text,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          )),
    );
  }
}
