extension StringExtension on String {
  String capitalize() {
    return split(' ')
        .map((word) {
          if (word.isNotEmpty) {
            return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
          }
          return word;
        })
        .join(' ');
  }

  String guideImage() {
    return '${toLowerCase().replaceAll(' ', '')}.jpg';
  }

  String maskNik() {
    if (length < 16) return this;

    const visiblePrefix = 4;
    const visibleSuffix = 1;
    const maskChar = '*';

    final prefix = substring(0, visiblePrefix);
    final suffix = substring(length - visibleSuffix);
    final maskedLength = length - visiblePrefix - visibleSuffix;

    return '$prefix${maskChar * maskedLength}$suffix';
  }

  String maskEmail() {
    if (!contains('@')) {
      return this;
    }

    final parts = split('@');
    final username = parts[0];
    final domain = parts.sublist(1).join('@');

    if (username.length <= 2) {
      return '${username[0]}***@$domain';
    }

    final visibleStart = username[0];
    final visibleEnd = username[username.length - 1];
    final maskedLength = username.length - 2;
    final asterisks = '*' * (maskedLength > 5 ? 5 : maskedLength);

    return '$visibleStart$asterisks$visibleEnd@$domain';
  }

  String? maskUsername() {
    if (trim().isEmpty) {
      return null;
    }

    final visibleChars = 2;
    final maxStars = 5;
    final trimmed = trim();
    final len = trimmed.length;

    if (len <= visibleChars) {
      return '${trimmed[0]}***';
    }

    final start = trimmed.substring(0, visibleChars);
    final end = trimmed.substring(len - 1);

    final maskedCount = len - (visibleChars + 1);
    final stars =
        '*' *
        (maskedCount > maxStars
            ? maxStars
            : (maskedCount < 1 ? 1 : maskedCount));

    return '$start$stars$end';
  }

  String? formatRt(List<String> rts) {
    if (trim().isEmpty) {
      return null;
    }

    final formatted = trim().padLeft(3, '0');

    if (rts.contains(formatted)) {
      return formatted;
    }

    return null;
  }

  String? formatRw(List<String> rws) {
    if (trim().isEmpty) {
      return null;
    }

    final formatted = trim().padLeft(3, '0');

    if (rws.contains(formatted)) {
      return formatted;
    }

    return null;
  }
}
