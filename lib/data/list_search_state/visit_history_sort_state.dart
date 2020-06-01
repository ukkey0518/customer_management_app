enum VisitHistorySortState {
  REGISTER_DATE,
  PAYMENT_AMOUNT,
  CUSTOMER_AGE,
  CUSTOMER_NAME,
}

const Map<VisitHistorySortState, String> visitHistorySortStateMap = {
  VisitHistorySortState.REGISTER_DATE: '施術日順',
  VisitHistorySortState.PAYMENT_AMOUNT: '金額順',
  VisitHistorySortState.CUSTOMER_AGE: '年齢順',
  VisitHistorySortState.CUSTOMER_NAME: '顧客名順',
};
