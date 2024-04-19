import 'dart:developer';
import 'dart:ffi';

import 'package:dont_touch_phone/Application/Services/Navigation/app_navigation.dart';
import 'package:dont_touch_phone/Application/Services/db.dart';
import 'package:dont_touch_phone/Data/ads_data.dart';
import 'package:dont_touch_phone/Data/app_colors.dart';
import 'package:dont_touch_phone/Data/app_textstyles.dart';
import 'package:dont_touch_phone/Data/assets.dart';
import 'package:dont_touch_phone/Data/extensions/styling.dart';
import 'package:dont_touch_phone/Presentation/Commons/app_text.dart';
import 'package:dont_touch_phone/Presentation/Sounds/sounds_screen.dart';
import 'package:dont_touch_phone/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeMasterScreen extends StatefulWidget {
  const HomeMasterScreen({super.key});

  @override
  State<HomeMasterScreen> createState() => _HomeMasterScreenState();
}

class _HomeMasterScreenState extends State<HomeMasterScreen> {
  bool isStarted = false;
  @override
  void initState() {
    getData();
    showAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightRed,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor.withOpacity(0.2),
            ),
            clipBehavior: Clip.hardEdge,
            child: MaterialButton(
                padding: const EdgeInsets.all(14),
                onPressed: () {
                  AppNavigation.to(context, const SoundsScreen());
                },
                child: SvgPicture.asset(Assets.musicIcon)),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.heightGap(),
            FutureBuilder(
                future: AdService().loadBanner(bannerAdId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: snapshot.data!.size.width.toDouble(),
                      height: snapshot.data!.size.height.toDouble(),
                      child: AdWidget(ad: snapshot.data!),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
            40.heightGap(),
            Container(
              clipBehavior: Clip.hardEdge,
              height: MediaQuery.sizeOf(context).width * .6,
              width: MediaQuery.sizeOf(context).width * .6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor.withOpacity(0.2),
              ),
              child: MaterialButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  startOrStopService();
                },
                child: Center(
                  child: Container(
                    height: MediaQuery.sizeOf(context).width * .6,
                    width: MediaQuery.sizeOf(context).width * .6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.whiteColor.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Container(
                        height: MediaQuery.sizeOf(context).width * .5,
                        width: MediaQuery.sizeOf(context).width * .5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Container(
                            height: MediaQuery.sizeOf(context).width * .4,
                            width: MediaQuery.sizeOf(context).width * .4,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor,
                            ),
                            child: Center(
                              child: Apptext(
                                text: isStarted ? "Stop" : 'Start',
                                style: AppTextStyles.circularStdBold(
                                    color: AppColors.lightRed, fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            20.heightGap(),
            Apptext(
              text: 'Tap to start',
              style: AppTextStyles.circularStdMedium(
                fontSize: 24,
                color: AppColors.whiteColor.withOpacity(0.8),
              ),
            ),
            FutureBuilder(
                future: AdService().loadBanner(bannerAdId2),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: snapshot.data!.size.width.toDouble(),
                      height: snapshot.data!.size.height.toDouble(),
                      child: AdWidget(ad: snapshot.data!),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }

  startOrStopService() async {
    bool started = await FlutterBackgroundService().isRunning();
    log('first $started');
    try {
      if (started) {
        //stop
        FlutterBackgroundService().invoke('stop');
        isStarted = false;
      } else {
        await initializeBg();
        isStarted = true;
      }

      // List allRecords2 = await DatabaseHelper.instance.getAll();
      // int id2 = allRecords2.last['id'];
      // isStarted = id2 == 0 ? false : true;
      setState(() {});
    } catch (e) {
      log("E $e");
    }
  }

  void getData() async {
    await Future.delayed(Duration.zero);
    isStarted = await FlutterBackgroundService().isRunning();
    log("INIT $isStarted");
    setState(() {});
    // List allRecords = await DatabaseHelper.instance.getAll();
    // if (allRecords.isEmpty) {
    //   DatabaseHelper.instance.insertTrigger({'id': 0});
    //   isStarted = false;
    //   setState(() {});
    // } else {
    //   int id = allRecords.last['id'];
    //   isStarted = id == 0 ? false : true;
    // }
  }

  void showAd() async {
    await Future.delayed(const Duration(seconds: 1));
    AdService.loadinterStatial(interstatialAdId: interstatialAdId);
  }
}
