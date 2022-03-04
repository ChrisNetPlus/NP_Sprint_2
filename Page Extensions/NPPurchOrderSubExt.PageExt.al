pageextension 50056 "NP Purch. Order Sub Ext" extends "Purchase Order Subform"
{
    layout
    {
        addbefore("Shortcut Dimension 1 Code")
        {
            field("NP Direct to Contract"; Rec."NP Direct to Contract")
            {
                Caption = 'Direct to Contract';
                ToolTip = 'Tick if you are delivering direct to contract';
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
}
