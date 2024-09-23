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


//--------------------------------------------------------------------------------
// Variables and Constants

//--------------------------------------------------------------------------------
/**
*/
class WMSOrder
{
//--------------------------------------------------------------------------------
//@public members
//--------------------------------------------------------------------------------

  //------------------------------------------------------------------------------
  /** The Default Constructor.
  */
  public WMSOrder()
  {
  }

  public static FindOrderTypeFromOrder(string rawOrder, string &orderType)
  {
    dyn_mapping orderMapping = jsonDecode(rawOrder);

    mapping orderTypeMapping = orderMapping.first();
    orderType = orderTypeMapping.value("Order");
  }

  public static FindRafSiraNoFromOrder(string rawOrder, string &rafSiraNo)
  {
    dyn_mapping orderMapping = jsonDecode(rawOrder);

    mapping rafSiraNoMapping = orderMapping.last();
    rafSiraNo = rafSiraNoMapping.value("RafSiraNo");
  }

  public static vector< shared_ptr<WMSOrderData> > GetWMSOrderInstances()
  {
    return  WMSOrderInstances;
  }

  public static CreateOrderInstance(string rawOrder, string orderType, string rafSiraNo)
  {
    shared_ptr<WMSOrderData> wmsOrderInstance = new WMSOrderData(rawOrder,orderType,rafSiraNo);

    DebugN("----->",wmsOrderInstance);
//     WMSOrderInstances.append(wmsOrderInstance);

  }

//--------------------------------------------------------------------------------
//@protected members
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
//@private members
//--------------------------------------------------------------------------------
  public vector< shared_ptr<WMSOrderData> > WMSOrderInstances;
};
