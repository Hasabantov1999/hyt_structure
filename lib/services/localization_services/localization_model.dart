import 'package:hive_flutter/hive_flutter.dart';
part "localization_model.g.dart";

@HiveType(typeId: 2)
class LocalizationModel extends HiveObject {
  @HiveField(0,defaultValue: "tr")
   String? locale;
  @HiveField(1,defaultValue: {})
   Map<String, String>? translates;
  LocalizationModel({required this.locale, required this.translates});
}
