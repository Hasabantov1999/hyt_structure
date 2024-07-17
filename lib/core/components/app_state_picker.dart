
import 'package:fast_structure/core/components/app_text.dart';
import 'package:fast_structure/core/extensions/context_extensions.dart';
import 'package:fast_structure/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';
import '../../public/radius_palette.dart';
import '../util/city_state_service.dart';
import 'app_textfield.dart';


class DentalCityStatePicker extends StatefulWidget {
  const DentalCityStatePicker({
    Key? key,
    required this.ilController,
    this.onChanged,
    required this.ilceController,
  }) : super(key: key);
  final TextEditingController ilController;
  final TextEditingController ilceController;
  final Function(String?)? onChanged;

  @override
  State<DentalCityStatePicker> createState() => _TripyIlIlcePickerViewState();
}

class _TripyIlIlcePickerViewState extends State<DentalCityStatePicker> {
  CityModel ilModel = CityModel(ilName: "Şehir");
  StateModel ilceModel = StateModel(ilceName: "İlçe");
  bool focusPinPut = false;

  @override
  void initState() {
    super.initState();
    loadInitialIlIlce();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TextEditingController controller = TextEditingController();

  void loadInitialIlIlce() {
    ilModel = CityModel(ilName: "Şehir");
    ilceModel = StateModel(ilceName: "İlçe");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppTextfield(
            hint: "Şehir",
            controller: widget.ilController,
            onTap: () async {
              final data = await context.modalPush(
                const TripyIlWidgetView(),
              );

              if (data != null && data is CityModel) {
                ilModel = data;
                widget.ilController.text = ilModel.ilName!;
                ilceModel = StateModel(ilceName: "İlçe");
                widget.ilceController.text = ilceModel.ilceName!;
                setState(() {});
              }
            },
          ),
          SizedBox(
            height: 13.h,
          ),
          AppTextfield(
            hint: "İlçe",
            controller: widget.ilceController,
            onTap: () async {
              final data = await context.modalPush(
                TripyIlceWidgetView(
                  ilceList: ilModel.states!,
                ),
              );

              if (data != null && data is StateModel) {
                ilceModel = data;
                widget.ilceController.text = ilceModel.ilceName!;
                setState(() {});
              }
            },
          ),
          // SizedBox(
          //   width: context.width * 0.4,
          //   child: InkWell(
          //     borderRadius: BorderRadius.circular(4),
          //     onTap: () async {
          //       final data = await context.modalPush(
          //         const TripyIlWidgetView(),
          //       );

          //       if (data != null && data is CityModel) {
          //         ilModel = data;
          //         widget.ilController.text = ilModel.ilName!;
          //         ilceModel = StateModel(ilceName: "İlçe");
          //         widget.ilceController.text = ilceModel.ilceName!;
          //         setState(() {});
          //       }
          //     },
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SizedBox(
          //           width: 13.w,
          //         ),
          //         Text(
          //           ilModel.ilName!,
          //           style: context.appTheme.inputDecorationTheme.labelStyle,
          //         ),
          //         SizedBox(
          //           width: 4.w,
          //         ),
          //         Icon(
          //           Icons.arrow_drop_down,
          //           color: context.appTheme.textTheme.bodyMedium?.color,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // const VerticalDivider(color: Colors.white),
          // SizedBox(
          //   width: context.width * 0.4,
          //   child: IgnorePointer(
          //     ignoring: ilModel.ilName == "Şehir",
          //     child: InkWell(
          //       borderRadius: BorderRadius.circular(4),
          //       onTap: () async {
          //         final data = await context.modalPush(
          //           TripyIlceWidgetView(
          //             ilceList: ilModel.states!,
          //           ),
          //         );

          //         if (data != null && data is StateModel) {
          //           ilceModel = data;
          //           widget.ilceController.text = ilceModel.ilceName!;
          //           setState(() {});
          //         }
          //       },
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           SizedBox(
          //             width: 13.w,
          //           ),
          //           Text(
          //             ilceModel.ilceName!.toLowerCase().capitalize(),
          //             style: context.appTheme.inputDecorationTheme.labelStyle,
          //           ),
          //           SizedBox(
          //             width: 4.w,
          //           ),
          //           Icon(
          //             Icons.arrow_drop_down,
          //             color: context.appTheme.textTheme.bodyMedium?.color,
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CityModel {
  CityModel({
    this.ilName,
    this.plateCode,
    this.states,
  });

  String? ilName;
  String? plateCode;
  List<StateModel>? states;

  factory CityModel.fromJson(Map<String, dynamic> json) {
    var list = json["ilceler"] as List;

    List<StateModel> ilcelerList =
        list.map((i) => StateModel.fromJson(i)).toList();

    return CityModel(
      ilName: json["il_adi"],
      plateCode: json["plaka_kodu"],
      states: json["ilceler"] != null ? ilcelerList : null,
    );
  }
}

class StateModel {
  StateModel({
    this.ilceName,
    this.ilceCode,
    this.ilName,
    this.plateCode,
  });

  String? ilceName, ilName, ilceCode, plateCode;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        ilceName: json["ilce_adi"],
        ilName: json["il_adi"],
        ilceCode: json["ilce_kodu"],
        plateCode: json["plaka_kodu"],
      );
}

class TripyIlceWidgetView extends StatefulWidget {
  const TripyIlceWidgetView({
    Key? key,
    required this.ilceList,
  }) : super(key: key);
  final List<StateModel> ilceList;

  @override
  State<TripyIlceWidgetView> createState() => _TripyIlceWidgetViewState();
}

class _TripyIlceWidgetViewState extends State<TripyIlceWidgetView> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  List<StateModel> searcableList = [];

  void searchText() {
    searcableList = [];
    for (var element in widget.ilceList) {
      if (element.ilceName!.contains(textController.text)) {
        searcableList.add(element);
      }
    }
    setState(() {});
  }

  Future<void> loadData() async {
    searcableList = widget.ilceList;
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 386.w,
        height: 700.h,
        margin: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + 20.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: RadiusPalette.radius40,
        ),
        child: Material(
          borderRadius: RadiusPalette.radius40,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Padding(
                padding: context.initialHorizantalPadding,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.confetti,
                    ),
                    AppTextfield(
                      hint: "",
                      example: "Arama yap!",
                      controller: textController,
                      textInputAction: TextInputAction.done,
                      suffixIcon: const Icon(Icons.search),
                      onChanged: (val) {
                        searchText();
                      },
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                            itemCount: searcableList.length,
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              try {
                                return ListTile(
                                  onTap: () {
                                    context.pop<StateModel?>(
                                      searcableList[index],
                                    );
                                  },
                                  title: Text(
                                    searcableList[index]
                                        .ilceName!
                                        .toLowerCase()
                                        .capitalize(),
                                    style: context.appTheme.inputDecorationTheme
                                        .labelStyle
                                        ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                return Container();
                              }
                            })),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          context.pop();
                        },
                        child: const AppText(
                          "Vazgeç",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: -56.h,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.mainColors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: ColorPalette.mainColors.blue.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 10,
                        )
                      ]),
                  padding: EdgeInsets.all(20.w),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    Assets.svg.profile.infoSquare,
                    width: 82.w,
                    height: 82.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TripyIlWidgetView extends StatefulWidget {
  const TripyIlWidgetView({Key? key}) : super(key: key);

  @override
  State<TripyIlWidgetView> createState() => _TripyIlWidgetViewViewState();
}

class _TripyIlWidgetViewViewState extends State<TripyIlWidgetView> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  List<CityModel> searcableList = [];

  void searchText() {
    searcableList = [];
    for (var element in CodeFinderService.instance.ilIlceList) {
      if (element.ilName!.contains(textController.text)) {
        searcableList.add(element);
      }
    }
    setState(() {});
  }

  Future<void> loadData() async {
    searcableList = CodeFinderService.instance.ilIlceList;
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 386.w,
        height: 700.h,
        margin: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + 20.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: RadiusPalette.radius40,
        ),
        child: Material(
          borderRadius: RadiusPalette.radius40,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Padding(
                padding: context.initialHorizantalPadding,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.confetti,
                    ),
                    AppTextfield(
                      hint: "",
                      example: "Arama yap!",
                      controller: textController,
                      textInputAction: TextInputAction.done,
                      suffixIcon: const Icon(Icons.search),
                      onChanged: (val) {
                        searchText();
                      },
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                            itemCount: searcableList.length,
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              try {
                                return ListTile(
                                  onTap: () {
                                    context.pop<CityModel?>(
                                      searcableList[index],
                                    );
                                  },
                                  title: Text(
                                    searcableList[index]
                                        .ilName!
                                        .toLowerCase()
                                        .capitalize(),
                                    style: context.appTheme.inputDecorationTheme
                                        .labelStyle
                                        ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                return Container();
                              }
                            })),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          context.pop();
                        },
                        child: const AppText(
                          "Vazgeç",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: -56.h,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.mainColors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: ColorPalette.mainColors.blue.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 10,
                        )
                      ]),
                  padding: EdgeInsets.all(20.w),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    Assets.svg.profile.infoSquare,
                    width: 82.w,
                    height: 82.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
