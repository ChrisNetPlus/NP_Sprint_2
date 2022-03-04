pageextension 50047 "NP Cust. Ledger Entries Ext" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Customer No.")
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
