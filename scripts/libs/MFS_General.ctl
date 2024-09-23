// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author mehmetsalihsaglam
*/

//--------------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/WMSOrderData"
#uses "classes/enumerationOrders"
#uses "constants"



//--------------------------------------------------------------------------------
// Variables and Constants
//--------------------------------------------------------------------------------

public uint FindOrderTypeFromOrder(string rawOrder)
{
  uint orderType;
  dyn_mapping orderMapping = jsonDecode(rawOrder);

  mapping orderTypeMapping = orderMapping.first();
  orderType = orderTypeMapping.value("Order");

  return orderType;
}

public string FindRafSiraNoFromOrder(string rawOrder)
{
  string rafSiraNo;
  dyn_mapping orderMapping = jsonDecode(rawOrder);

  mapping rafSiraNoMapping = orderMapping.last();
  rafSiraNo = rafSiraNoMapping.value("RafSiraNo");

  return rafSiraNo;
}

public dyn_string FindEquipmentList(string rafSiraNo, uint orderType)
{
  dyn_string eqpList;
  string availableMekik = FindAvailableMekik(rafSiraNo);
  string availableLift = FindAvailableLift(orderType);

  eqpList.append(availableMekik);
  eqpList.append(availableLift);

  return eqpList;
}

private string FindAvailableLift(uint orderType)
{
  dyn_string liftNames = dpNames("*","MFS_Lift_Equipment_Information");
  for(uint i=0; i<liftNames.count(); ++i)
  {
    uint workingType;
    bool available;

    dpGet(liftNames.at(i) + ".Config.WorkingType:_original.._value",workingType,
              liftNames.at(i) + ".SPI.Available:_original.._value",available);

     if(orderType == workingType && available)
    {
      return liftNames.at(i);
    }
  }

  return liftNames.first();
}

private string FindAvailableMekik(string rafSiraNo)
{
  dyn_string dyn_temp = strsplit(rafSiraNo,"-");
  uint floorNo = dyn_temp.first();
  uint siraNo = dyn_temp.last();

  dyn_string mekikNames = dpNames("*","MFS_Mekik_Equipment_Information");
  for(uint i=0; i<mekikNames.count(); ++i)
  {
    uint actualFloorNumber;
    bool available;

    dpGet(mekikNames.at(i) + ".SPI.Floor:_original.._value",actualFloorNumber,
              mekikNames.at(i) + ".SPI.Available:_original.._value",available);

     if(actualFloorNumber == floorNo && available)
    {
      return mekikNames.at(i);
    }
    else
    {
      //To Do
    }
  }

  return mekikNames.first();
}

public void CreateOrderInstance(string rawOrder, uint orderType, string rafSiraNo, dyn_string eqpList)
{
  string orderId = createUuid();
  shared_ptr<WMSOrderData> wmsOrderInstance = new WMSOrderData(orderId,rawOrder,orderType,rafSiraNo,eqpList);

  WmsOrderInstances.append(wmsOrderInstance);

  DebugN("----->",WmsOrderInstances);
}

//--------------------------------------------------------------------------------
//@public members
//--------------------------------------------------------------------------------


//--------------------------------------------------------------------------------
//@private members
//--------------------------------------------------------------------------------

private vector< shared_ptr<WMSOrderData> > WmsOrderInstances;
