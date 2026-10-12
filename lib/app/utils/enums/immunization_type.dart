enum ImmunizationType {
  unknown(label: 'Tidak Diketahui'),
  hb(label: 'HB'),
  dptHb1(label: 'DPT-HB 1'),
  dptHb2(label: 'DPT-HB 2'),
  dptHb3(label: 'DPT-HB 3'),
  dptHbl(label: 'DPT-HB L'),
  polio1(label: 'Polio 1'),
  polio2(label: 'Polio 2'),
  polio3(label: 'Polio 3'),
  polio4(label: 'Polio 4'),
  campak(label: 'Campak'),
  campakL(label: 'Campak L'),
  bcg(label: 'BCG'),
  ipv1(label: 'IPV 1'),
  ipv2(label: 'IPV 2'),
  rotav1(label: 'ROTAV 1'),
  rotav2(label: 'ROTAV 2'),
  rotav3(label: 'ROTAV 3'),
  pcv1(label: 'PCV 1'),
  pcv2(label: 'PCV 2'),
  pcv3(label: 'PCV 3');

  final String label;

  new({required this.label});

  factory ImmunizationType.fromString(String? value) {
    if (value == null || value.isEmpty) {
      return .unknown;
    }

    switch (value) {
      case 'HB':
        return .hb;
      case 'DPT-HB 1':
        return .dptHb1;
      case 'DPT-HB 2':
        return .dptHb2;
      case 'DPT-HB 3':
        return .dptHb3;
      case 'DPT-HB L':
        return .dptHbl;
      case 'Polio 1':
        return .polio1;
      case 'Polio 2':
        return .polio2;
      case 'Polio 3':
        return .polio3;
      case 'Polio 4':
        return .polio4;
      case 'Campak':
        return .campak;
      case 'Campak L':
        return .campakL;
      case 'BCG':
        return .bcg;
      case 'IPV 1':
        return .ipv1;
      case 'IPV 2':
        return .ipv2;
      case 'ROTAV 1':
        return .rotav1;
      case 'ROTAV 2':
        return .rotav2;
      case 'ROTAV 3':
        return .rotav3;
      case 'PCV 1':
        return .pcv1;
      case 'PCV 2':
        return .pcv2;
      case 'PCV 3':
        return .pcv3;
      default:
        return .unknown;
    }
  }

  static List<ImmunizationType> get filteredValues => values.where((element) {
    return element != .unknown;
  }).toList();
}
