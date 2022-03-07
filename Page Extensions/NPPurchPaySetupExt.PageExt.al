pageextension 50057 "NP Purch. Pay. Setup Ext" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("NP BACS File Path")
        {
            field("NP Direct Delivery Journal"; Rec."NP Direct Delivery Journal")
            {
                Caption = 'Direct Delivery Journal';
                ToolTip = 'The journal batch to be used for direct delivery receipts';
                ApplicationArea = All;
            }
        }
    }
}
