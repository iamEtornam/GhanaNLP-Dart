enum Language {
  twi('tw'),
  yoruba('yo'),
  ga('gaa'),
  dagbani('dag'),
  ewe('ee'),
  kikuyu('ki');

  final String code;
  const Language(this.code);

  static Language fromCode(String code) {
    return Language.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => throw ArgumentError('Invalid language code: $code'),
    );
  }
}
