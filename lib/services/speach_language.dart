const languages = const [
  const Language('English', 'en_US'),
  const Language('Francais', 'fr_FR'),
  const Language('Pусский', 'ru_RU'),
  const Language('Italiano', 'it_IT'),
  const Language('Español', 'es_ES'),
  const Language('Bangla', 'bn'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}