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
            field("NP Disallow PO Print"; Rec."NP Disallow PO Print")
            {
                Caption = 'Disable PO Printing';
                ToolTip = 'This will disable PO Print and Email if the order is not Released';
                ApplicationArea = All;
            }
        }
    }
}
