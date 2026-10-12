enum Boolean {
  yes(valueBool: true, valueNumber: 1, valueString: 'ya'),
  no(valueBool: false, valueNumber: 0, valueString: 'tidak');

  final bool valueBool;
  final int valueNumber;
  final String valueString;

  const new({
    required this.valueBool,
    required this.valueNumber,
    required this.valueString,
  });

  factory Boolean.fromBool(bool? value) {
    if (value == null) {
      return Boolean.no;
    }

    return Boolean.values.firstWhere(
      (element) => element.valueBool == value,
      orElse: () => Boolean.no,
    );
  }

  factory Boolean.fromNumber(int? value) {
    if (value == null) {
      return Boolean.no;
    }

    return Boolean.values.firstWhere(
      (element) => element.valueNumber == value,
      orElse: () => Boolean.no,
    );
  }

  factory Boolean.fromString(String? value) {
    if (value == null || value.isEmpty) {
      return Boolean.no;
    }

    return Boolean.values.firstWhere(
      (element) => element.valueString == value,
      orElse: () => Boolean.no,
    );
  }
}
