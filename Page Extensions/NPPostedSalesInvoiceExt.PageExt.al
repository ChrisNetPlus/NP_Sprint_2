pageextension 50045 "NP Posted Sales Invoice Ext" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("NP Credit Controller"; Rec."NP Credit Controller")
            {
                ApplicationArea = All;
                Caption = 'Credit Controller';
                ToolTip = 'Credit Controller';
            }
        }
    }
}
