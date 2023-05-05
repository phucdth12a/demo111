import 'package:json_annotation/json_annotation.dart';

class DynamicToIntConverter implements JsonConverter<int?, dynamic> {
  const DynamicToIntConverter();

  @override
  int? fromJson(dynamic value) {
    if (value != null) {
      if (value is num) return value.toInt();
      if (value is String && value.isNotEmpty) return int.tryParse(value);
    }
    return null;
  }

  @override
  dynamic toJson(int? value) => value;
}
