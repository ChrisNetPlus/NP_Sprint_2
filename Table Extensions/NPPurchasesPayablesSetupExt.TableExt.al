tableextension 50022 "NP PurchasesPayablesSetupExt" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50003; "Enable PO Cancelling"; Boolean)
        {
            Caption = 'Enable PO Cancelling';
            DataClassification = CustomerContent;
        }
        field(50004; "NP Disallow PO Print"; Boolean)
        {
            Caption = 'Disallow PO Printing';
            DataClassification = CustomerContent;
        }
    }
}
