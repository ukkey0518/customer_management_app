extension ConvertFromMap<K, V> on Map<K, V> {
  // [取得：valueからkeyを取得]
  K getKeyFromValue(V value) {
    final entries = this.entries.toList();
    final key = entries.where((entry) => entry.value == value);
    final returnKey = key.isEmpty ? null : key.single.key;
    return returnKey;
  }
}
