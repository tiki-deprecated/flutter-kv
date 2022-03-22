class TikiKVModel {
  int? id;
  late String key;
  late String value;

  TikiKVModel({
    required this.id,
    required this.key,
    required this.value,
  });

  TikiKVModel.fromJson(Map<String, dynamic>? json) {
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
