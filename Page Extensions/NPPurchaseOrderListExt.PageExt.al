pageextension 50039 "NP Purchase Order List Ext" extends "Purchase Order List"
{
    actions
    {
        modify(Print)
        {
            Visible = EnablePrint;
        }
        modify(AttachAsPDF)
        {
            Visible = EnablePrint;
        }
        modify(Send)
        {
            Visible = EnablePrint;
        }

    }
    trigger OnAfterGetRecord()
    var
        PurchPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchPayablesSetup.Get();
        if PurchPayablesSetup."NP Disallow PO Print" then begin
            if Rec.Status <> Rec.Status::Released then
                EnablePrint := false
            else
                EnablePrint := true;
        end;
    end;

    var
        EnablePrint: Boolean;

}
