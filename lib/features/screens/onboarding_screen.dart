import 'package:flutter/material.dart';
import 'package:ieee_ticket_scanner/core/database/cache/cache_helper.dart';
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';
import 'package:ieee_ticket_scanner/features/screens/main_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primary,
        child: IntroductionScreen(
          nextStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppColors.primary),
          ),
          doneStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppColors.primary),
          ),
          skipStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppColors.primary),
          ),
          pages: [
            PageViewModel(
              title: 'Qr Code',
              body:
                  'Each member of the audience has his own Qr Code to be able to enter the event.',
              image: Image.asset('assets/images/onboarding_audience.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Scan Qr Code',
              body:
                  'Each member scans their Qr code to register their attendance every day',
              image: Image.asset('assets/images/onboarding_scan.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Acceptation',
              body:
                  'If the QR Code is present in the database, the member will be registered successfully',
              image: Image.asset('assets/images/onboarding_accept.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Rejection',
              body:
                  'If the QR Code is not present in the database or was registered on the same day before, the program will not accept this code',
              image: Image.asset('assets/images/onboarding_reject.png'),
              decoration: getPageDecoration(),
            ),
          ],
          next: const Icon(Icons.arrow_forward),
          done: const Text(
            'Done',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onDone: () async {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const MainScreen()));
            await CacheHelper().saveData(key: "first_time", value: false);
            bool c =await CacheHelper().getData(key: "first_time");
            print(c);
          },
          showSkipButton: true,
          skip: const Text('Skip'),
          dotsDecorator: getDotDecoration(),
        ),
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
      bodyTextStyle: TextStyle(fontSize: 22),
      imagePadding: EdgeInsets.all(50),
      titlePadding: EdgeInsets.all(8),
      bodyPadding: EdgeInsets.all(20),
      pageColor: Colors.white,
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
        color: const Color(0xFFBDBDBD),
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeColor: AppColors.primary,
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)));
  }
}
