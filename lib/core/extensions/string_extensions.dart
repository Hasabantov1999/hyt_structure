import 'package:intl/intl.dart';

import '../../services/hive_services/hive_services.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String toCapitalized() =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String getDateTime({String? format}) {
    return DateFormat(format, LocalCacheService.instance.model().systemLocale)
        .format((DateTime.tryParse(this) ?? DateTime.now()));
  }


}
