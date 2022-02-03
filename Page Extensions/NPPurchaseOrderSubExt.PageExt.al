pageextension 50034 "NP PurchaseOrderSubExt" extends "Purchase Order Subform"
{
    layout
    {
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                ErrorLabel: Label 'This order is cancelled!';
            begin
                Rec.CalcFields("NP Cancelled Order");
                if Rec."NP Cancelled Order" then
                    Error(ErrorLabel);
            end;
        }
    }
}
