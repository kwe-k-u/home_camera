import 'package:flutter/material.dart';
import 'package:home_camera/pages/home_page.dart';
import 'package:home_camera/services/app_service.dart';
import 'package:home_camera/widgets/custom_rounded_button.dart';
import 'package:home_camera/widgets/custom_text_field.dart';
import 'package:home_camera/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController ipController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    context.read<AppService>().getDeviceIP().then((ip) =>
        ipController.text = "${ip.split(".").sublist(0, 3).join(".")}.1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(-3, 3),
                  blurStyle: BlurStyle.normal)
            ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                const HeaderText("The Best Security is one you build yourself"),
                CustomTextField(
                  label: "IP Address of Camera system",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: ipController,
                ),
                CustomTextField(
                  label: "Username",
                  controller: usernameController,
                ),
                CustomTextField(
                  label: "Password",
                  controller: passwordController,
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                )
              ],
            ),
          ),
          const Spacer(),
          CustomRoundedButton(
              label: "Login",
              onTap: () async {
                context
                    .read<AppService>()
                    .login(
                        ipaddress: ipController.text,
                        username: usernameController.text,
                        password: passwordController.text)
                    .then((result) {
                  if (context.mounted) {
                    if (result["status"]) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result["reason"]),
                        ),
                      );
                    }
                  }
                });
              }),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Text("Don't know how to set up?"),
              ),
              CustomRoundedButton(
                  width: MediaQuery.of(context).size.width * 0.2,
                  label: "Get Help",
                  onTap: () {})
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
