import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/hive_models/app_cache_models.dart';
import '../../services/hive_services/model/cache_key_model.dart';


class AppCacheBuilder extends StatelessWidget {
  const AppCacheBuilder({super.key, required this.builder});
  final Widget Function(BuildContext, AppCacheModel, Widget?) builder;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          Hive.box<AppCacheModel?>(DataBaseConstants.app).listenable(),
      builder: (context, box, child) {
        return builder(
            context, box.get(BoxConstants.app) ?? AppCacheModel(), child);
      },
    );
  }
}
