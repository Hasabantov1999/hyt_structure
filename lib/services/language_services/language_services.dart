
import '../../vendors/translator/translator.dart';
import '../hive_services/hive_services.dart';

class LanguageService {
  static Future<String> translate(String sentences) async {
    if (LocalCacheService.instance.model().systemLocale == "en") {
      return sentences;
    }
    Translation translation = await InjectionLimits.translotor.translate(
        sentences,
        to: LocalCacheService.instance.model().systemLocale ?? "tr");

    return translation.text;
  }
}

class InjectionLimits {
  static GoogleTranslator translotor = GoogleTranslator();
}
