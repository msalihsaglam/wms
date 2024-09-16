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

  /*
  Parse order from WMS.
  Find orderType and rafSiraNo
 */

 int orderType;
 string rafSiraNo;
 ParseOrder(value,orderType,rafSiraNo);

 DebugN("orderType:",orderType);
 DebugN("rafSiraNo:",rafSiraNo);

 bool result = StartProcess(orderType,rafSiraNo);
 DebugN("result:",result);

  /*
  Check if there is any inprogress sequence
   If yes, the order should be taken into buffer list
   If no, order must be considered.
 */

   if(result)
   {
      SendOrderToBuffer(value);
   }
   else
   {
     //CreateSequence
   }
}
