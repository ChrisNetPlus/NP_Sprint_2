pageextension 50037 "NP Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter("Tax Area Code")
        {
            field("NP Customer Registration No."; Rec."NP Customer Registration No.")
            {
                Caption = 'Company Registration No.';
                ToolTip = 'Company Registration No.';
                ApplicationArea = All;
            }
            field("NP UTR Number"; Rec."NP UTR Number")
            {
                Caption = 'UTR Number';
                ToolTip = 'UTR Number';
                ApplicationArea = All;

            }
        }
    }
}
