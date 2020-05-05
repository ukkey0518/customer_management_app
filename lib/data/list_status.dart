enum VisitHistoryNarrowState {
  ALL,
  TODAY,
  FEMALE,
  MALE,
}

enum VisitHistorySortState {
  REGISTER_NEW,
  REGISTER_OLD,
  NAME_FORWARD,
  NAME_REVERSE,
}

enum CustomerNarrowState {
  ALL,
  FEMALE,
  MALE,
}

enum CustomerSortState {
  REGISTER_NEW,
  REGISTER_OLD,
  NAME_FORWARD,
  NAME_REVERSE,
}

class CustomerListScreenPreferences {
  CustomerListScreenPreferences(
      {this.narrowState, this.sortState, this.searchWord});
  CustomerNarrowState narrowState;
  CustomerSortState sortState;
  String searchWord;
}

class VisitHistoryListScreenPreferences {
  VisitHistoryListScreenPreferences(
      {this.narrowState, this.sortState, this.searchWord});
  VisitHistoryNarrowState narrowState;
  VisitHistorySortState sortState;
  String searchWord;
}
