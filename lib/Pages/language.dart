


class Language {
  final int id;
  final String name;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList = [
    Language(1, "English", "en"),
    Language(2, "اَلْعَرَبِيَّةُ", "ar"),
  ];
}