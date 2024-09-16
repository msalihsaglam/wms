// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author mehmetsalihsaglam
*/

//--------------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/enumerationOrders"



//--------------------------------------------------------------------------------
// Variables and Constants
//--------------------------------------------------------------------------------


public bool IsYuklemeInProgress()
{
  //Check Yukleme Sequence state element
  return false;
}

public bool IsBosaltmaInProgress()
{
  //Check Bosaltma Sequence state element
  return false;
}

public bool IsSequenceInprogress(string seqDP)
{
  int state;
  dpGet(seqDP + ".State.state:_original.._value",state); // state can be another enumeration

  bool inProgress;
  if(state == 1)
    inProgress = true;
  else
    inProgress = false;

  return inProgress;
}

public void ParseOrder(string order, int &orderType, string &rafSiraNo)
{
  dyn_mapping orderMapping = jsonDecode(order);

  mapping orderTypeMapping = orderMapping.first();
  orderType = orderTypeMapping.value("Order");

  mapping rafSiraNoMapping = orderMapping.last();
  rafSiraNo = rafSiraNoMapping.value("RafSiraNo");
}

public bool StartProcess(int orderType, string rafSiraNo)
{
  string seqDP = GetSequenceDP(orderType);
  DebugN("seqDP:",seqDP);

 bool inProgress =  IsSequenceInprogress(seqDP);
 return inProgress;
}

public bool SendOrderToBuffer(string order)
{
  dyn_string orderList;
  dpGet("WMS_Order.Order.bufferOrderList:_original.._value",orderList);
  DebugN("First:",orderList);
  orderList.append(order);
  DebugN("Second:",orderList);
  dpSet("WMS_Order.Order.bufferOrderList:_original.._value",orderList);

  return true;
}

private string GetSequenceDP(int orderType)
{
  string orderSuffix;
  string dp;
  mapping enumMap = enumValues("OrderTypes");

  for (uint i=0; i<enumMap.count(); ++i)
  {
      if (enumMap.valueAt(i) == orderType)
      {
        orderSuffix = enumMap.keyAt(i);
      }
  }

  dp = "MFS_" + orderSuffix + "_Sequence_CFG";
  return dp;
}

private bool deneme()
{
  return false;
}



//--------------------------------------------------------------------------------
//@public members
//--------------------------------------------------------------------------------


//--------------------------------------------------------------------------------
//@private members
//--------------------------------------------------------------------------------

