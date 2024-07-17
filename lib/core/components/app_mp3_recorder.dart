// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';


import 'package:permission_handler/permission_handler.dart';
import 'package:audio_session/audio_session.dart';

import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';
import '../../public/radius_palette.dart';
import '../error/error_patch.dart';
import '../util/developer_log.dart';
import 'app_mp3_player.dart';
import 'app_text.dart';

class RecordAudio extends StatefulWidget {
  const RecordAudio({
    super.key,
    required this.onChanged,
    this.saveButton = false,
  });
  final void Function(File? file) onChanged;
  final bool saveButton;
  @override
  State<RecordAudio> createState() => RecordAudioState();
}

class RecordAudioState extends State<RecordAudio> {
  ValueNotifier<File?> audioFile = ValueNotifier(null);
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  ValueNotifier<RecorderState> state = ValueNotifier(RecorderState.IDLE);
  Future<Map<String, dynamic>> get codecFinder async {
    Map<String, dynamic> completer = {
      "path": "tau_file.mp4",
      "codec": Codec.defaultCodec
    };

    for (var codec in Codec.values) {
      if (await recorder.isEncoderSupported(codec)) {
        completer = {"codec": codec, "path": "tau_file${ext[codec.index]}"};
      }
    }
    DeveloperLog.instance.logSuccess("Recorder Completer: $completer");
    return completer;
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    if (recorder.isRecording) {
      recorder.stopRecorder();
    }
    super.dispose();
  }

  Future<void> record() async {
    if (getState == RecorderState.IDLE) {
      return;
    }
    if (getState == RecorderState.HASFILE) {
      widget.onChanged(null);
    }
    final credentials = await codecFinder;
    recorder
        .startRecorder(
      toFile: credentials['path'],
      codec: credentials['codec'],
    )
        .onError((error, stackTrace) {
      DeveloperErrorLog.instance.logService(
        error ?? "",
        stackTrace,
        "Start Record",
      );
      setRecorderState(RecorderState.ERROR);
    });
    setRecorderState(RecorderState.RECORDING);
  }

  Future<void> stopRecord() async {
    if (getState == RecorderState.IDLE) {
      return;
    }
    String? path = await recorder.stopRecorder();
    if (path != null) {
      audioFile.value = File(path);
      if (!widget.saveButton) {
        widget.onChanged(audioFile.value!);
      }

      setRecorderState(RecorderState.HASFILE);
    }
  }

  void setRecorderState(RecorderState state) {
    this.state.value = state;
    DeveloperLog.instance.logInfo("Recorder State Change By ${state.name}");
  }

  RecorderState get getState => state.value;
  Future<void> initRecorder() async {
    if (await getPermissions()) {
      await recorder.openRecorder();
      await recorderOptions();
      setRecorderState(RecorderState.NONE);
    }
  }

  Future<void> recorderOptions() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<bool> getPermissions() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      setRecorderState(RecorderState.NO_PERMISSION);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: state,
      builder: (context, state, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppText(
              'Sesli Şikayetinizi Gönderin',
              textAlign: TextAlign.center,
            ),
            if (state == RecorderState.RECORDING) Container(),
            Builder(builder: (context) {
              if (state == RecorderState.NONE) {
                return GestureDetector(
                  onTap: () async {
                    await record();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: 22.w,
                      vertical: 13.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalette.grayColors.grayBg,
                      borderRadius: RadiusPalette.radius10,
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.svg.micCircle,
                          color: ColorPalette.mainColors.blue,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        AppText(
                          'Ses Kaydetmeye Başla',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state == RecorderState.RECORDING) {
                return GestureDetector(
                  onTap: () async {
                    await stopRecord();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: 22.w,
                      vertical: 13.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalette.grayColors.grayBg,
                      borderRadius: RadiusPalette.radius10,
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.svg.micCircle,
                          color: ColorPalette.mainColors.blue,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        const AppText(
                          'Ses Kaydetmeyi Durdur',
                        )
                      ],
                    ),
                  ),
                );
              } else if (state == RecorderState.HASFILE) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    MP3Player(
                      path: audioFile.value!.path,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await record();
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 22.w,
                          vertical: 13.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorPalette.grayColors.grayBg,
                          borderRadius: RadiusPalette.radius10,
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              Assets.svg.micCircle,
                              color: ColorPalette.mainColors.blue,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            AppText(
                              'Tekrar Dene',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (widget.saveButton)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              widget.onChanged(audioFile.value!);
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                horizontal: 22.w,
                                vertical: 13.h,
                              ),
                              decoration: BoxDecoration(
                                color: ColorPalette.grayColors.grayBg,
                                borderRadius: RadiusPalette.radius10,
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.save,
                                    color: ColorPalette.mainColors.blue,
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  AppText(
                                    'Kaydet',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                );
              }

              return const SizedBox.shrink();
            })
          ],
        );
      },
    );
  }
}

enum RecorderState { IDLE, RECORDING, NONE, HASFILE, ERROR, NO_PERMISSION }
