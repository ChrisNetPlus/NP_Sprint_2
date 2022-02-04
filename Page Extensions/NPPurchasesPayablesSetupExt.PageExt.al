pageextension 50036 "NP PurchasesPayablesSetupExt" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Ignore Updated Addresses")
        {
            field("NP Enable PO Cancelling"; Rec."Enable PO Cancelling")
            {
                Caption = 'Enable PO Cancelling';
                ToolTip = 'To enable purchase orders to be cancelled';
                ApplicationArea = All;
            }
        }
    }
}
