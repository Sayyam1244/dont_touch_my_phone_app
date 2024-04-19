import 'package:dont_touch_phone/Application/Services/Navigation/app_navigation.dart';
import 'package:dont_touch_phone/Data/app_colors.dart';
import 'package:dont_touch_phone/Data/assets.dart';
import 'package:dont_touch_phone/Presentation/HomeMaster/home_master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    triggerNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightRed,
      body: Center(
        child: Container(
          height: MediaQuery.sizeOf(context).width / 2,
          width: MediaQuery.sizeOf(context).width / 2,
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteColor.withOpacity(0.2),
          ),
          child: SvgPicture.asset(Assets.logo),
        ),
      ),
    );
  }

  triggerNavigation() async {
    await Future.delayed(const Duration(seconds: 1));
    AppNavigation.toReplaceAll(context, HomeMasterScreen());
  }
}
