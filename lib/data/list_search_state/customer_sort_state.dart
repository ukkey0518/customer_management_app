enum CustomerSortState {
  LAST_VISIT,
  FIRST_VISIT,
  EXPECTED_NEXT_VISIT,
  NAME,
  AGE,
  NUM_OF_VISITS,
  TOTAL_PAYMENT,
  REPEAT_CYCLE,
}

const Map<CustomerSortState, String> customerSortStateMap = {
  CustomerSortState.LAST_VISIT: '最終来店日順',
  CustomerSortState.FIRST_VISIT: '初回来店日順',
  CustomerSortState.EXPECTED_NEXT_VISIT: '次回来店予想日順',
  CustomerSortState.NAME: '名前順',
  CustomerSortState.AGE: '年齢順',
  CustomerSortState.NUM_OF_VISITS: '総来店回数順',
  CustomerSortState.TOTAL_PAYMENT: 'お支払い総額順',
  CustomerSortState.REPEAT_CYCLE: 'リピートサイクル順',
};
