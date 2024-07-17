import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../public/color_palette.dart';
import 'app_animated_button.dart';


class MP3Player extends StatefulWidget {
  const MP3Player({super.key, required this.path});
  final String path;

  @override
  State<MP3Player> createState() => MP3PlayerState();
}

class MP3PlayerState extends State<MP3Player>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;
  late final AnimationController _payCtr;
  bool isInit = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _payCtr = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      if (_.isPlaying) {
        playPauseListener(true);
      } else if (_.isPaused) {
        playPauseListener(false);
      } else {
        playPauseListener(false);
      }
    });
    super.initState();
  }

  void playPauseListener(bool isPlaying) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isPlaying) {
        if (mounted) _payCtr.forward();
      }
      if (!isPlaying) {
        if (mounted) _payCtr.reverse();
      }
    });
  }

  void _preparePlayer() async {
    // Opening file from assets folder

    // Prepare player with extracting waveform if index is even.
    await controller.preparePlayer(
      path: widget.path,
    );
    // Extracting waveform separately if index is odd.

    await controller.extractWaveformData(
      path: widget.path,
    );

    isInit = true;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isInit
        ? const SizedBox.shrink()
        : Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorPalette.grayColors.grayBg,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialIconButton(
                  onPressed: () async {
                    controller.playerState.isPlaying
                        ? await controller.pausePlayer()
                        : await controller.startPlayer(
                            finishMode: FinishMode.pause,
                          );
                  },
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    color: Colors.white,
                    progress: _payCtr,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                AudioFileWaveforms(
                  size: Size(280.w, 30),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  playerController: controller,
                  waveformType: WaveformType.fitWidth,
                  enableSeekGesture: false,
                  playerWaveStyle: PlayerWaveStyle(
                    fixedWaveColor: const Color(0xFF677294),
                    liveWaveColor: ColorPalette.mainColors.blue,
                    spacing: 3,
                    waveThickness: 2.w,
                    seekLineColor: ColorPalette.mainColors.blue,
                    seekLineThickness: 3.w,
                  ),
                ),
              ],
            ),
          );
  }
}
