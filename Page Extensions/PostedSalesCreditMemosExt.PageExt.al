pageextension 50049 "Posted Sales Credit Memos Ext" extends "Posted Sales Credit Memos"
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
