enum VisitHistorySortState {
  REGISTER_NEW,
  REGISTER_OLD,
}

const Map<VisitHistorySortState, String> visitHistorySortStateMap = {
  VisitHistorySortState.REGISTER_OLD: '登録順(古)',
  VisitHistorySortState.REGISTER_NEW: '登録順(新)',
};
