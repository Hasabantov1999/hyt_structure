
import 'package:fast_structure/core/components/app_text.dart';
import 'package:fast_structure/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';
import '../../public/radius_palette.dart';
import '../util/city_state_service.dart';
import 'app_textfield.dart';



class AppCountryCodePickerView extends StatefulWidget {
  const AppCountryCodePickerView(
      {Key? key,
      required this.controller,
      this.onChanged,
      this.onCountryChanged,
      this.hintText,
      this.focusNode,
      this.textInputAction})
      : super(key: key);
  final TextEditingController controller;
  final Function(String?)? onChanged;
  final Function(CountryModel?)? onCountryChanged;
  final String? hintText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  @override
  State<AppCountryCodePickerView> createState() =>
      _TripyCountryCodePickerViewState();
}

class _TripyCountryCodePickerViewState extends State<AppCountryCodePickerView> {
  CountryModel countryModel = CountryModel(
    countryCode: "TR",
    name: "Türkiye Cumhuriyeti",
    callingCode: "+90",
    flag: "flags/tur.svg",
  );
  bool focusPinPut = false;

  @override
  void initState() {
    super.initState();

    loadInitialCountry();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController controller = TextEditingController();

  Future<void> loadInitialCountry() async {
    await CodeFinderService.instance.loadCountryData();
    countryModel = CodeFinderService.instance.myCountryCode ??
        CountryModel(
          countryCode: "TR",
          name: "Türkiye Cumhuriyeti",
          callingCode: "+90",
          flag: "flags/tur.svg",
        );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextfield(
      hint: widget.hintText ?? "Telefon Numarası",
      example: "(555) 555-55-55",
      iconPath: Assets.svg.inputPhone,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      inputFormatters: [
        MaskTextInputFormatter(
          mask: '(###) ###-##-##',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy,
        ),
      ],
      suffixIcon: InkWell(
        onTap: () async {
          final data = await context.modalPush(
            const TripyCountryWidgetView(),
          );

          if (data != null && data is CountryModel) {
            countryModel = data;
            setState(() {});
            if (widget.onCountryChanged != null) {
              widget.onCountryChanged!(countryModel);
            }
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/${countryModel.flag ?? ""}",
              width: 18,
              height: 18,
            ),
            const Icon(
              Icons.keyboard_arrow_down,
            )
          ],
        ),
      ),
    );
  }
}

class TripyCountryWidgetView extends StatefulWidget {
  const TripyCountryWidgetView({Key? key, this.countryCode = true})
      : super(key: key);
  final bool countryCode;

  @override
  State<TripyCountryWidgetView> createState() => _TripyCountryWidgetViewState();
}

class _TripyCountryWidgetViewState extends State<TripyCountryWidgetView> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  List<CountryModel> searcableList = [];

  void searchText() {
    searcableList = [];
    for (var element in CodeFinderService.instance.countryList) {
      if (element.name!.contains(textController.text) ||
          element.callingCode!.contains(textController.text) ||
          element.countryCode!.contains(textController.text)) {
        searcableList.add(element);
      }
    }
    setState(() {});
  }

  Future<void> loadData() async {
    searcableList = CodeFinderService.instance.countryList;
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
                                    context.pop<CountryModel?>(
                                      searcableList[index],
                                    );
                                  },
                                  leading: SvgPicture.asset(
                                    'assets/${searcableList[index].flag}',
                                    width: 25,
                                    height: 25,
                                  ),
                                  minLeadingWidth: 25,
                                  title: Row(
                                    children: [
                                      if (widget.countryCode)
                                        SizedBox(
                                          width: kMinInteractiveDimension,
                                          child: Text(
                                            searcableList[index].callingCode!,
                                          ),
                                        ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        searcableList[index].name!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
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
