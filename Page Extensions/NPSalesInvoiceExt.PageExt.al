pageextension 50031 "NP Sales Invoice Ext" extends "Sales Invoice"
{
    layout
    {
        addafter(Status)
        {
            field("NP Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                Caption = 'Posting No.';
                ToolTip = 'Amend Posting No. Here';
                Editable = true;
            }
        }
    }
}
