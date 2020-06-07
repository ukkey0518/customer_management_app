class CustomerNarrowData {
  CustomerNarrowData({
    this.numOfVisits,
    this.isGenderFemale,
    this.age,
    this.sinceLastVisit,
    this.untilLastVisit,
    this.sinceNextVisit,
    this.untilNextVisit,
    this.visitReason,
  });

  String numOfVisits;
  bool isGenderFemale;
  String age;
  DateTime sinceLastVisit;
  DateTime untilLastVisit;
  DateTime sinceNextVisit;
  DateTime untilNextVisit;
  String visitReason;

  // [判定：何かしらの絞り込み条件が設定されているか]
  bool isSetAny() {
    final flag = numOfVisits != null ||
        isGenderFemale != null ||
        age != null ||
        sinceLastVisit != null ||
        untilLastVisit != null ||
        sinceNextVisit != null ||
        untilNextVisit != null ||
        visitReason != null;
    print('$flag');
    return flag;
  }

  // [変更：条件をすべてクリアする]
  void clear() {
    numOfVisits = null;
    isGenderFemale = null;
    age = null;
    sinceLastVisit = null;
    untilLastVisit = null;
    sinceNextVisit = null;
    untilNextVisit = null;
    visitReason = null;
  }

  @override
  String toString() {
    return '[C]NarrowData(nov: $numOfVisits, g: $isGenderFemale, age: $age, slv: $sinceLastVisit, ulv: $untilLastVisit, snv: $sinceNextVisit, unv: $untilNextVisit, vr: $visitReason)';
  }
}
