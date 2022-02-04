tableextension 50022 PurchasesPayablesSetupExt extends "Purchases & Payables Setup"
{
    fields
    {
        field(50003; "Enable PO Cancelling"; Boolean)
        {
            Caption = 'Enable PO Cancelling';
            DataClassification = CustomerContent;
        }
    }
}
