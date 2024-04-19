import 'package:dont_touch_phone/Application/Services/Navigation/app_navigation.dart';
import 'package:dont_touch_phone/Application/Services/db.dart';
import 'package:dont_touch_phone/Data/ads_data.dart';
import 'package:dont_touch_phone/Data/app_colors.dart';
import 'package:dont_touch_phone/Data/app_textstyles.dart';
import 'package:dont_touch_phone/Data/assets.dart';
import 'package:dont_touch_phone/Data/extensions/styling.dart';
import 'package:dont_touch_phone/Data/sounds_data.dart';
import 'package:dont_touch_phone/Presentation/Commons/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';

class SoundsScreen extends StatefulWidget {
  const SoundsScreen({super.key});

  @override
  State<SoundsScreen> createState() => _SoundsScreenState();
}

class _SoundsScreenState extends State<SoundsScreen> {
  List<SoundModel> soundData = sounds;

  @override
  void initState() {
    AdService.loadinterStatial(interstatialAdId: interstatialAdId2);
    getSelected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightRed,
      appBar: AppBar(
        title: Apptext(
          text: 'Sounds',
          style: AppTextStyles.circularStdBold(
            fontSize: 30,
            color: AppColors.whiteColor,
          ),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leadingWidth: 100,
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
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
                AppNavigation.pop(context);
              },
              child:
                  const Icon(Icons.arrow_back_ios, color: AppColors.whiteColor)
                      .onlyPadding(l: 6)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: soundData.length,
        itemBuilder: (context, index) {
          return Soundtile(
            soundModel: soundData[index],
            triggerGetAll: () async {
              await getSelected();
            },
          ).onlyPadding(b: 10);
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index % 2 == 0) {
            return FutureBuilder(
                future: AdService().loadBanner(bannerAdId3),
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
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future getSelected() async {
    await Future.delayed(Duration.zero);
    await DatabaseHelper.instance.getAll().then((value) {
      soundData = soundData.where((element) {
        if (element.url == value.last['url']) {
          element.isSelected = true;
        } else {
          element.isSelected = false;
        }
        return true;
      }).toList();
    });
    setState(() {});
  }
}

class Soundtile extends StatefulWidget {
  Soundtile({
    super.key,
    required this.soundModel,
    required this.triggerGetAll,
  });
  final SoundModel soundModel;
  final Function triggerGetAll;
  @override
  State<Soundtile> createState() => _SoundtileState();
}

class _SoundtileState extends State<Soundtile> {
  ExpansionTileController controller = ExpansionTileController();
  AudioPlayer audio = AudioPlayer();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: controller,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: AppColors.whiteColor,
      collapsedBackgroundColor: AppColors.whiteColor,
      leading: SvgPicture.asset(
        Assets.musicIcon,
        color: AppColors.blackColor.withOpacity(0.8),
      ),
      tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      title: Row(
        children: [
          Apptext(
            text: widget.soundModel.name,
            style: AppTextStyles.circularStdMedium(
                fontSize: 20, color: AppColors.blackColor.withOpacity(0.8)),
          ),
          widget.soundModel.isSelected
              ? Apptext(
                  text: ' (Active)',
                  style: AppTextStyles.circularStdMedium(
                      fontSize: 12, color: Colors.green),
                )
              : const SizedBox(),
        ],
      ),
      children: [
        ListTile(
          onTap: () {
            if (audio.playing) {
              audio.stop();
            } else {
              audio.setAsset(widget.soundModel.url);
              audio.play();
            }
            setState(() {});
          },
          leading: Icon(
            Icons.volume_down_rounded,
            color: AppColors.blackColor.withOpacity(0.8),
          ),
          title: Apptext(
            text: audio.playing ? "Stop" : 'Play sound',
            style: AppTextStyles.circularStdMedium(
                fontSize: 16, color: AppColors.blackColor.withOpacity(0.8)),
          ),
        ),
        ListTile(
          onTap: () async {
            if (widget.soundModel.isSelected == false) {
              await DatabaseHelper.instance
                  .insertTrigger({'url': widget.soundModel.url});
              await widget.triggerGetAll();
              controller.collapse();
              setState(() {});
            }
          },
          leading: SvgPicture.asset(
            Assets.logo,
            color: AppColors.lightRed,
            height: 16,
            width: 16,
          ).onlyPadding(l: 4),
          title: Apptext(
            text: widget.soundModel.isSelected
                ? "Currently Selected"
                : 'Set sound',
            style: AppTextStyles.circularStdMedium(
                fontSize: 16, color: AppColors.blackColor.withOpacity(0.8)),
          ),
        ),
      ],
    );
  }
}
