pageextension 50034 "NP PurchaseOrderSubExt" extends "Purchase Order Subform"
{
    layout
    {
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                ErrorLabel: Label 'This order is cancelled!';
                PurchPayablesSetup: Record "Purchases & Payables Setup";
            begin
                PurchPayablesSetup.Get();
                if not PurchPayablesSetup."Enable PO Cancelling" then
                    exit;
                Rec.CalcFields("NP Cancelled Order");
                if Rec."NP Cancelled Order" then
                    Error(ErrorLabel);
            end;
        }
    }
}
