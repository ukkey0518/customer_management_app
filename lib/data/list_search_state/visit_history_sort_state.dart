enum VisitHistorySortState {
  REGISTER_NEW,
  REGISTER_OLD,
}

const Map<VisitHistorySortState, String> visitHistorySortStateMap = {
  VisitHistorySortState.REGISTER_NEW: '施術日順(新)',
  VisitHistorySortState.REGISTER_OLD: '施術日順(古)',
};
