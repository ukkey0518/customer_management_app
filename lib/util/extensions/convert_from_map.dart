extension ConvertFromMap<K, V> on Map<K, V> {
  // [取得：valueからkeyを取得]
  // ・valueが存在しない場合はnullを返す
  // ・valueが複数存在する場合は例外発生
  K getKeyFromValue(V value) {
    final entries = this.entries.toList();
    var keyList = entries.where((entry) => entry.value == value);
    var key;
    switch (keyList.length) {
      case 0:
        key = null;
        break;
      case 1:
        key = keyList.single.key;
        break;
      default:
        throw Exception('Valueに一致するKeyが複数存在 : ${keyList.length}');
    }
    return key;
  }
}
