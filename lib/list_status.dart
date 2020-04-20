enum ListNarrowState {
  ALL,
  TODAY,
  FEMALE,
  MALE,
}

enum ListSortState {
  REGISTER_NEW,
  REGISTER_OLD,
  NAME_FORWARD,
  NAME_REVERSE,
}

class ListScreenPreferences {
  ListScreenPreferences({this.narrowState, this.sortState, this.searchWord});
  ListNarrowState narrowState;
  ListSortState sortState;
  String searchWord;
}
