pageextension 50040 "NP New User Setup Ext" extends "User Setup"
{
    layout
    {
        addafter("Allow Negative Adj.")
        {
            field("NP Allow PO Invoice"; Rec."NP Disallow PO Invoice")
            {
                Caption = 'Disallow PO Invoice';
                ToolTip = 'Ticking this stops the user from posting a purchase order to invoice';
                ApplicationArea = All;
            }
            field("NP Depot Worker"; Rec."NP Depot Worker")
            {
                Caption = 'Depot Worker';
                ToolTip = 'Depot Worker';
                ApplicationArea = All;

            }
        }
    }
}
