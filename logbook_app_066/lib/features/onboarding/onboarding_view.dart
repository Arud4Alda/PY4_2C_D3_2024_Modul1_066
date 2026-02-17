import 'package:flutter/material.dart';
import 'package:logbook_app_001/features/auth/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});
  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> 
{
  int step = 1; // state untuk menyimpan halaman onboarding saat ini

  void nextStep() 
  {
    setState(() {step++;});
    // jika sudah lebih dari 3 → pindah ke Login
    if (step > 3) 
    {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginView()),);
    }
  }

// Widget buildImage() {
//     switch (step) {
//       case 1:
//         return Image.asset(
//           'package:logbook_app_001/assets/images/1.jpg',
//           height: 250,
//         );
//       case 2:
//         return Image.asset(
//           'package:logbook_app_001/assets/images/2.jpg',
//           height: 250,
//         );
//       case 3:
//         return Image.asset(
//           'package:logbook_app_001/assets/images/3.jpg',
//           height: 250,
//         );
//       default:
//         return const SizedBox();
//     }
//   }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
              Text("Halaman Onboarding ",
                style: const TextStyle
                (
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              //buildImage(),
              Text('$step', style: const TextStyle(fontSize: 110)),
              const SizedBox(height: 40),

              ElevatedButton
              (
                onPressed: nextStep,
                child: const Text("Lanjut"),
              ),
          ],
        ),
       ),
      )
    );
  }
}
