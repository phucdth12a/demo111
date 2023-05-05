extension StringExtension on String {
  String capitalize() {
    if (isNotEmpty) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }
    return '';
  }

  String unescape() {
    return replaceAll('&amp;', '&')
        .replaceAll('&#039;', "'")
        .replaceAll('&quot;', '"')
        .trim();
  }

  String formatToHHMMSS() {
    final int? time = int.tryParse(this);
    if (time != null) {
      final int hours = time ~/ 3600;
      final int seconds = time % 3600;
      final int minutes = seconds ~/ 60;

      final String hoursStr = hours.toString().padLeft(2, '0');
      final String minutesStr = minutes.toString().padLeft(2, '0');
      final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

      if (hours == 0) {
        return '$minutesStr:$secondsStr';
      }
      return '$hoursStr:$minutesStr:$secondsStr';
    }
    return '';
  }

  String get yearFromEpoch =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(this) * 1000)
          .year
          .toString();
}

extension DateTimeExtension on int {
  String formatToHHMMSS() {
    if (this != 0) {
      return toString().formatToHHMMSS();
    }
    return '';
  }

  int get yearFromEpoch =>
      DateTime.fromMillisecondsSinceEpoch(this * 1000).year;
}
