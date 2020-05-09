extension ConvertFromMap<K, V> on Map<K, V> {
  // [取得：valueからkeyを取得]
  K getKeyFromValue(V value) {
    final entries = this.entries.toList();
    return entries.where((entry) => entry.value == value).single.key;
  }
}
