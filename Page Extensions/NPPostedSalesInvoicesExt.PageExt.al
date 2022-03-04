pageextension 50048 "NP Posted Sales Invoices Ext" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Sell-to Customer No.")
        {
            field("NP Credit Controller"; Rec."NP Credit Controller")
            {
                ApplicationArea = All;
                Caption = 'Credit Controller';
                ToolTip = 'Credit Controller';
                Editable = false;
            }
        }
    }
}
