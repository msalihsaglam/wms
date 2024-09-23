// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author mehmetsalihsaglam
*/

//--------------------------------------------------------------------------------
// Libraries used (#uses)
#uses "MFS_General"
//--------------------------------------------------------------------------------
// Variables and Constants

//--------------------------------------------------------------------------------
/**
*/
main()
{
  dpConnect("GetOrderCB",false,"System1:WMS_Order.Order.actualOrder:_original.._value");
}

public void GetOrderCB(string dp, string value)
{
//   WMSOrderData wmsOrderInstance;
  uint orderType;
  string rafSiraNo;
  dyn_string equipmentList;

  orderType = FindOrderTypeFromOrder(value);
  rafSiraNo = FindRafSiraNoFromOrder(value);
  equipmentList = FindEquipmentList(rafSiraNo,orderType);


  CreateOrderInstance(value, orderType, rafSiraNo, equipmentList);

//   DebugN("---->",WMSOrder::GetWMSOrderInstances());

//   ParseOrder(order, orderType, rafSiraNo);

//   wmsOrderInstance = new WMSOrderData(value, orderType, rafSiraNo);

}
