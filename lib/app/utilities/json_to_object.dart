import 'dart:convert';

dynamic jsonToObject<T>(String jsonString, T Function(Map<String, dynamic> json) fromJson) {
  final jsonData = jsonDecode(jsonString);
  if (jsonData is List) {
    return jsonData.map(
      (item) {
        final itemMap = item as Map<String, dynamic>;
        return fromJson(itemMap);
      }
    ).toList();
  }
  if (jsonData is T) {
    return jsonData;
  }
  try {
    return fromJson(jsonData as Map<String, dynamic>);
  } catch (e) {
    print('Error parsing JSON: $e');
    return null;
  }
}