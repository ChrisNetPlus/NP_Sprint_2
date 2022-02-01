pageextension 50032 "NP Sales Credit Memo Ext" extends "Sales Credit Memo"
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
