pageextension 50046 "NP Posted Sales Cr. Memo Ext" extends "Posted Sales Credit Memo"
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
