// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author mehmetsalihsaglam
*/

//--------------------------------------------------------------------------------
// Libraries used (#uses)

//--------------------------------------------------------------------------------
// Variables and Constants

//--------------------------------------------------------------------------------
/**
*/
class WMSOrderData
{
//--------------------------------------------------------------------------------
//@public members
//--------------------------------------------------------------------------------

  //------------------------------------------------------------------------------
  /** The Default Constructor.
  */
  public WMSOrderData(string orderId,string rawOrder, uint orderType, string rafSiraNo, dyn_string equipmentList, dyn_string sequence)
  {
    this.orderId = orderId;
    this.rawOrder = rawOrder;
    this.orderType = orderType;
    this.rafSiraNo = rafSiraNo;
    this.equipmentList = equipmentList;
    this.sequence = sequence;
  }

//--------------------------------------------------------------------------------
//@protected members
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
//@private members
//--------------------------------------------------------------------------------

  private string rawOrder;
  private uint orderType;
  private string rafSiraNo;
  private string orderId;
  private dyn_string equipmentList;
  private string sequence;
  private uint sequenceStatus;

};
