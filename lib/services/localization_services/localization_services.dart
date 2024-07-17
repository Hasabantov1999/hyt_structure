import '../../vendors/translator/src/google_translator.dart';
import '../hive_services/hive_services.dart';
import 'localization_model.dart';
import 'package:hive/hive.dart';

class LocalizationCacheService {
  static LocalizationCacheService? _instance;

  static LocalizationCacheService get instance =>
      _instance ??= LocalizationCacheService._init();

  LocalizationCacheService._init();

  Box<LocalizationModel?>? _box;
  Box<String?>? _rememberMeBox;

  Box<LocalizationModel?> get getBox => _box!;

  Box<String?>? get getRememberMeBox => _rememberMeBox!;

  LocalizationModel model() {
    if (_box?.get(_key) == null) {
      initInstance().then((value) {
        return _box!.get(_key)!;
      });
    }
    return _box!.get(_key)!;
  }

  Future<void> setModel(LocalizationModel appCacheModel) async {
    _box!.put(_key, appCacheModel);
  }

  Future<void> initInstance() async {
    _box = await Hive.openBox<LocalizationModel?>(_database);

    if (_box!.get(_key) == null) {
      await _box!.put(
        _key,
        LocalizationModel(
          locale: 'tr',
          translates: {},
        ),
      );
    }
  }
}

const _key = "localeKey";
const _database = "databaseKey";

class LocalizationServices {
  static LocalizationServices? _instance;

  static LocalizationServices get instance =>
      _instance ??= LocalizationServices._init();
  LocalizationServices._init();

  Future<String> translate(String sentences, {String? language}) async {
    if (language == null &&
        LocalCacheService.instance.model().systemLocale == "tr") {
      return sentences;
    }

    if (language != null &&
        language == LocalCacheService.instance.model().systemLocale) {
      return sentences;
    }

    String? cacheSnc = _getCache(sentences);

    if (cacheSnc != null) {
      return cacheSnc;
    }

    Translation translation = await InjectionLimits.translotor.translate(
      sentences,
      from: language ?? "tr",
      to: LocalCacheService.instance.model().systemLocale!,
    );

    await _setCache(sentences, translation.text);

    return translation.text;
  }

  Future<void> _setCache(String sentences, String translate) async {
    bool isContain = false;
    LocalizationCacheService.instance.model().translates!.forEach((key, value) {
      if (key == EncryptUtil.cleaner(sentences)) {
        isContain = true;
      }
    });

    if (!isContain) {
      Map<String, String> translates =
          LocalizationCacheService.instance.model().translates!;
      translates.addAll(
        {EncryptUtil.cleaner(sentences): translate},
      );
      LocalizationCacheService.instance.model()
        ..translates = translates
        ..save();
    }
  }

  String? _getCache(String sentences) {
    String? w = LocalizationCacheService.instance
        .model()
        .translates![EncryptUtil.cleaner(sentences)];

    return w;
  }
}

class InjectionLimits {
  static GoogleTranslator translotor = GoogleTranslator();
}

class EncryptUtil {
  static String cleaner(String text) {
    return "&${LocalCacheService.instance.model().systemLocale}${text.replaceAll(" ", "").toLowerCase()}";
  }

  // Metni şifrelemek için kullanılan fonksiyon
}
