import 'dart:developer';
import 'dart:ui';

import 'package:dont_touch_phone/Application/Services/db.dart';
import 'package:dont_touch_phone/Data/sounds_data.dart';
import 'package:dont_touch_phone/Presentation/Splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:volume_controller/volume_controller.dart';

StreamSubscription? _streamSubscription;
@pragma('vm:entry-point')
initializeBg() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  FlutterBackgroundService service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(),
  );
  service.startService();
}

late AudioPlayer audioPlayer;

@pragma('vm:entry-point')
onStart(ServiceInstance service) async {
  audioPlayer = AudioPlayer();

  acceloMeterInit(() async {
    // await DatabaseHelper.instance.insertTrigger({"id": 1});

    // Check if player is initialized
    if (audioPlayer != null) {
      print('Player initialized');
      DatabaseHelper.instance.getAll().then((value) {
        print("URL " + value.last['url']);
        audioPlayer.setAsset(value.last['url']);
        VolumeController().maxVolume(showSystemUI: false);
        VolumeController().listener((v) {
          VolumeController().maxVolume(showSystemUI: false);
        });
        audioPlayer.setLoopMode(LoopMode.one);
        audioPlayer.play();
      });
    } else {
      print('AudioPlayer is not initialized');
    }
    print('"Triggered"');
  });

  service.on('stop').listen((event) async {
    // await DatabaseHelper.instance.insertTrigger({"id": 0});

    audioPlayer.stop();
    service.stopSelf();
    print('STOP called');
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  MobileAds.instance.initialize();
  // FlutterBackgroundService flutterBackgroundService =
  // FlutterBackgroundService();
  DatabaseHelper.instance;
  DatabaseHelper.instance.getAll().then((value) {
    if (value.isEmpty) {
      DatabaseHelper.instance.insertTrigger({"url": sounds[0].url});
    }
  });
  // await initializeBg();

  // final l = await flutterBackgroundService.isRunning();
  // log('Service: $l');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

acceloMeterInit(Function onTriggered) async {
  double x = 0;
  double y = 0;
  double z = 0;
  _streamSubscription =
      accelerometerEventStream(samplingPeriod: const Duration(seconds: 1))
          .listen(
    (AccelerometerEvent event) async {
      final roundedX = roundToMaxNineDigits(event.x);
      final roundedY = roundToMaxNineDigits(event.y);
      final roundedZ = roundToMaxNineDigits(event.z);
      if (x == 0 && y == 0 && z == 0) {
        x = roundedX;
        y = roundedY;
        z = roundedZ;
      }

      print("X: $roundedX  Y: $roundedY  Z: $roundedZ");
      print("X: $x  Y: $y  Z: $z --");
      if (x != roundedX && y != roundedY && z != roundedZ) {
        _streamSubscription?.cancel();
        onTriggered();
      }
    },
    onError: (error) {
      print(error.toString());
    },
    cancelOnError: true,
  );
}

double roundToMaxNineDigits(double value) {
  final int integerDigits = value.floor().toString().length;
  final int maxDecimalPlaces =
      2 - integerDigits; // Ensures max 8 digits after decimal
  return double.parse(value.toStringAsFixed(maxDecimalPlaces));
}
