/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class Model {
  int? id;
  late String key;
  late String value;

  Model({
    required this.id,
    required this.key,
    required this.value,
  });

  Model.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      key = json['key'];
      value = json['value'];
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'value': value,
      };
}
