pageextension 50020 "NP Activities Cue Ext" extends "O365 Activities"
{
    layout
    {
        addafter("Ongoing Sales Invoices")
        {
            field("NP Open Sales Credit Memos"; Rec."NP Open Sales Credit Memos")
            {
                Caption = 'Sales Credits';
                ToolTip = 'Specifies sales credits that are not yet posted or only partially posted.';
                DrillDownPageID = "Sales Credit Memos";
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
