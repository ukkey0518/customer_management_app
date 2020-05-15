enum CustomerSortState {
  REGISTER_NEW,
  REGISTER_OLD,
  NAME_FORWARD,
  NAME_REVERSE,
}

const Map<CustomerSortState, String> customerSortStateMap = {
  CustomerSortState.REGISTER_OLD: '登録順(古)',
  CustomerSortState.REGISTER_NEW: '登録順(新)',
  CustomerSortState.NAME_FORWARD: '名前順',
  CustomerSortState.NAME_REVERSE: '名前逆順',
};
