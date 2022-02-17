pageextension 50041 "NP Purchase Order Archives Ext" extends "Purchase Order Archives"
{
    layout
    {
        addafter("Vendor Authorization No.")
        {
            field("NP Amount"; Rec.Amount)
            {
                Caption = 'Amount';
                ToolTip = 'Total Amount for this Order';
                ApplicationArea = All;
            }
        }
    }
}
