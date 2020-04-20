enum ListNarrowState { ALL, TODAY }

enum ListSortState { REGISTER_NEW, REGISTER_OLD }

class ListScreenPreferences {
  ListScreenPreferences({this.narrowState, this.sortState});
  ListNarrowState narrowState;
  ListSortState sortState;
}
