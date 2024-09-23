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
  dpConnect("GetOrderCB",false,"WMS_Order.Order.actualOrder:_original.._value");
}

public void GetOrderCB(string dp, string value)
{
//   WMSOrderData wmsOrderInstance;
  uint orderType;
  string rafSiraNo;
  dyn_string equipmentList;
  dyn_string sequence;

  orderType = FindOrderTypeFromOrder(value);
  rafSiraNo = FindRafSiraNoFromOrder(value);
  equipmentList = FindEquipmentList(rafSiraNo,orderType);
  sequence = GetSequenceForOrder(orderType);


  CreateOrderInstance(value, orderType, rafSiraNo, equipmentList, sequence);

  SendCommandsToEquipments(equipmentList,sequence);
  //gokhan


//   DebugN("---->",WMSOrder::GetWMSOrderInstances());

//   ParseOrder(order, orderType, rafSiraNo);

//   wmsOrderInstance = new WMSOrderData(value, orderType, rafSiraNo);

}
