import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['pt', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? ptText = '',
    String? enText = '',
  }) =>
      [ptText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    'qg0a96q8': {
      'pt': 'Acalaes',
      'en': 'acales',
    },
    'yckxks3t': {
      'pt': 'Botão',
      'en': 'Button',
    },
    'fe1fvf28': {
      'pt': 'Get Started',
      'en': '',
    },
    'x86r29ow': {
      'pt': 'Casa',
      'en': 'Home',
    },
  },
  // EditProfile2
  {
    '5x2gto8b': {
      'pt': 'Change Cover Photo',
      'en': '',
    },
    'yv9qjgse': {
      'pt': 'Edit Photo',
      'en': '',
    },
    'g98tnemk': {
      'pt': 'Email Address',
      'en': '',
    },
    'w6rql7f5': {
      'pt': 'Your Name',
      'en': '',
    },
    'sw899unj': {
      'pt': 'Recieve Notifications',
      'en': '',
    },
    'y6i9jol9': {
      'pt': 'Turn on notifications.',
      'en': '',
    },
    '5thwvx0y': {
      'pt': 'Save Changes',
      'en': '',
    },
    '430w5jjd': {
      'pt': 'Edit Profile',
      'en': '',
    },
  },
  // Miscellaneous
  {
    'xxb0zxv5': {
      'pt': '',
      'en': '',
    },
    'b7jou2sa': {
      'pt': '',
      'en': '',
    },
    'ijwc984v': {
      'pt': '',
      'en': '',
    },
    'eiktiu18': {
      'pt': '',
      'en': '',
    },
    'sa932hy7': {
      'pt': '',
      'en': '',
    },
    'unp434dq': {
      'pt': '',
      'en': '',
    },
    'ym5effpx': {
      'pt': '',
      'en': '',
    },
    'y3f7q1st': {
      'pt': '',
      'en': '',
    },
    'ptn5kyol': {
      'pt': '',
      'en': '',
    },
    'u7lqrpsn': {
      'pt': '',
      'en': '',
    },
    'jt1hosju': {
      'pt': '',
      'en': '',
    },
    'octagmcb': {
      'pt': '',
      'en': '',
    },
    'yuhntnki': {
      'pt': '',
      'en': '',
    },
    '54suq4rf': {
      'pt': '',
      'en': '',
    },
    '08pqgc15': {
      'pt': '',
      'en': '',
    },
    'q9vphf1y': {
      'pt': '',
      'en': '',
    },
    '4d3fd572': {
      'pt': '',
      'en': '',
    },
    'e23vai7b': {
      'pt': '',
      'en': '',
    },
    'kbtp7qwj': {
      'pt': '',
      'en': '',
    },
    'l2e0xycv': {
      'pt': '',
      'en': '',
    },
    '2ihsemvr': {
      'pt': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
