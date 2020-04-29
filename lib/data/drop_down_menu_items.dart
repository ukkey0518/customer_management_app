import '../list_status.dart';

const Map<CustomerNarrowState, String> customerNarrowStateMap = {
  CustomerNarrowState.ALL: 'すべて',
  CustomerNarrowState.FEMALE: '女性のみ',
  CustomerNarrowState.MALE: '男性のみ',
};

const Map<CustomerSortState, String> customerSortStateMap = {
  CustomerSortState.REGISTER_OLD: '登録順(古)',
  CustomerSortState.REGISTER_NEW: '登録順(新)',
  CustomerSortState.NAME_FORWARD: '名前順',
  CustomerSortState.NAME_REVERSE: '名前逆順',
};
