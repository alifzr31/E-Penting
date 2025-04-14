class EndPoint {
  static const String login = '/login';
  static const String logout = '/logout';

  // POSYANDU
  static const String classification = '/classification';
  static const String weight = '/berat-badan';
  static const String nutrition = '/gizi';

  static const String percentage = '/percentage';
  static const String latestBalita = '/balita/latest';
  static const String latestPengukuran = '/penimbangan/latest';
  static const String latestImunisasi = '/imunisasi/latest';

  static const String allPengukuran = '/penimbangan/list';
  static const String searchPengukuran = '/penimbangan/search';
  static const String allImunisasi = '/imunisasi/list';
  static const String searchImunisasi = '/imunisasi/search';
  static const String allBalita = '/balita/list';
  static const String searchBalita = '/balita/search';

  static const String addPengukuran = '/penimbangan';
  static const String detailPengukuran = '/penimbangan/detail';
  static const String editPengukuran = '/penimbangan';

  static const String addImunisasi = '/imunisasi';
  static const String detailImunisasi = '/imunisasi/detail';
  static const String editImunisasi = '/imunisasi';

  static const String addBalita = '/balita/create';
  static const String detailBalita = '/balita/detail';
  static const String updateBalita = '/balita';

  // ORANG TUA
  static const String latestPengukuranBalita = '/balita/latest-nik';
  static const String latestVaccine = '/imunisasi/history-nik';
  static const String historyPengukuran = '/penimbangan/history';
}
