import 'package:weather_app/app/data/utils/string_util.dart';

extension MapUtils on Map<String, dynamic> {
  Map<String, dynamic> toStringMap() {
    return map((key, value) {
      if (value is List) {
        return MapEntry(key, value);
      }
      return MapEntry(key, value.toString());
    });
  }

  Map<String, dynamic> removeNullValues() {
    removeWhere((key, value) => value == null);
    return this;
  }

  Map<String, dynamic> encoded() {
    return map((key, value) {
      if (value is String) {
        String newValue = value.bracketsToCurlyBraces;
        return MapEntry(key, newValue);
      } else if (value is bool) {
        return MapEntry(key, value ? 1 : 0);
      }
      return MapEntry(key, value);
    });
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    forEach((key, value) {
      if (value is DateTime) {
        json[key] = value.toIso8601String();
      } else {
        json[key] = value;
      }
    });

    return json;
  }
}

extension MapExtensions<K, V> on Map<K, V> {
  bool allValuesNotNullOrEmpty() {
    return values.every((value) => value != null && value.toString().isNotEmpty);
  }

  bool containsValidValue(K key) {
    return containsKey(key) && this[key] != null && this[key].toString().isNotEmpty;
  }
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<R> mapIndex<R>(R Function(int index, T element) convert) sync* {
    var index = 0;
    for (var element in this) {
      yield convert(index++, element);
    }
  }
}
