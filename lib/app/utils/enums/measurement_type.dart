enum MeasurementType {
  unknown(label: 'Tidak Diketahui'),
  stand(label: 'Berdiri'),
  supine(label: 'Terlentang');

  final String label;

  const new({required this.label});

  factory MeasurementType.fromString(String? value) {
    if (value == null || value.isEmpty) {
      return .stand;
    }

    return MeasurementType.values.firstWhere((element) {
      return element.label.toLowerCase() == value;
    }, orElse: () => .stand);
  }

  static List<MeasurementType> get filteredValues => values.where((element) {
    return element != .unknown;
  }).toList();
}
