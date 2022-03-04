pageextension 50038 "NP Customer List Ext" extends "Customer List"
{
    layout
    {
        addafter(Contact)
        {
            field("NP Credit Controller"; Rec."NP Credit Controller")
            {
                Caption = 'Credit Controller';
                ToolTip = 'Credit Controller';
                ApplicationArea = All;

            }
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
            field("NP VAT Registration No."; Rec."VAT Registration No.")
            {
                Caption = 'VAT Registration No.';
                ToolTip = 'VAT Registration No.';
                ApplicationArea = All;
            }
        }
        modify("Credit Limit (LCY)")
        {
            Visible = true;
        }
    }
}
