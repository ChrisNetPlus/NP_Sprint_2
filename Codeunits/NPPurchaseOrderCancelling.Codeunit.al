codeunit 50203 "NP PurchaseOrderCancelling"
{
    procedure CancelPurchaseOrder(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        CancelledPurchaseLines: Record "NP Cancelled Purchase Lines";
        AlreadyCancelled: Label 'This Order is Already Cancelled';
        AlreadyReceived: Label 'This order is already received and cannot be cancelled';
        CancelReasonError: Label 'Please choose a Cancel Reason';
        DuplicateReason: Label 'Please enter a Related Order Number';
        Duplicate: Label 'DUPLICATE';
        PurchReleaseCU: Codeunit "Release Purchase Document";
        PurchPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchPayablesSetup.Get();
        if not PurchPayablesSetup."Enable PO Cancelling" then
            exit;
        if PurchaseHeader."NP Cancelled" then
            Error(AlreadyCancelled);
        if PurchaseHeader."NP Cancel Reason" = '' then
            Error(CancelReasonError);
        if PurchaseHeader."NP Cancel Reason" = Duplicate then begin
            if PurchaseHeader."NP Related Order No" = '' then
                Error(DuplicateReason);
        end;
        if PurchaseHeader.Status = PurchaseHeader.Status::Released then
            PurchReleaseCU.Reopen(PurchaseHeader);
        PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchHeader."No.");
        PurchaseLine.SetFilter("Quantity Received", '<>%1', 0);
        if PurchaseLine.FindFirst() then
            Error(AlreadyReceived);
        PurchHeader.Get(PurchaseHeader."Document Type", PurchaseHeader."No.");
        PurchHeader."NP Cancelled" := true;
        PurchHeader.Validate("NP Cancel Reason", PurchaseHeader."NP Cancel Reason");
        PurchHeader."NP Cancelled By" := UserId;
        PurchHeader."NP Cancelled On" := Today;
        PurchHeader.Modify();
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchHeader."No.");
        PurchaseLine.SetFilter(Quantity, '<>%1', 0);
        if PurchaseLine.FindSet() then
            repeat
                if PurchaseLine."NP Cancelled Order" then
                    Error(AlreadyCancelled);
                CancelledPurchaseLines.Init();
                CancelledPurchaseLines."Purchase Order No." := PurchaseLine."Document No.";
                CancelledPurchaseLines."Purchase Line No." := PurchaseLine."Line No.";
                CancelledPurchaseLines."Item No." := PurchaseLine."No.";
                CancelledPurchaseLines.Quantity := PurchaseLine.Quantity;
                CancelledPurchaseLines."Cancelled By" := UserId;
                CancelledPurchaseLines."Cancelled On" := Today;
                CancelledPurchaseLines."Cancel Reason Code" := PurchaseHeader."NP Cancel Reason";
                CancelledPurchaseLines."Cancel Reason Description" := PurchaseHeader."NP Cancel Reason Description";
                CancelledPurchaseLines."Cancel Restored" := false;
                CancelledPurchaseLines."NP Related Order No" := PurchaseHeader."NP Related Order No";
                if not CancelledPurchaseLines.Insert() then
                    CancelledPurchaseLines.Modify();
                PurchaseLine.Validate(Quantity, 0);
                PurchaseLine."NP Cancel Reason" := PurchaseHeader."NP Cancel Reason";
                PurchaseLine."NP Cancel Reason Description" := PurchaseHeader."NP Cancel Reason Description";
                PurchaseLine."NP Cancelled By" := UserId;
                PurchaseLine."NP Cancelled On" := Today;
                PurchaseLine.Modify();
            until PurchaseLine.Next() = 0;
    end;

    procedure UnCancelPurchaseOrder(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        CancelledPurchaseLines: Record "NP Cancelled Purchase Lines";
        AlreadyCancelled: Label 'This Order is Not Cancelled';
        PurchPayablesSetup: Record "Purchases & Payables Setup";
    begin
        if not PurchPayablesSetup."Enable PO Cancelling" then
            exit;
        if not PurchaseHeader."NP Cancelled" then
            Error(AlreadyCancelled);
        PurchHeader.Get(PurchaseHeader."Document Type", PurchaseHeader."No.");
        PurchHeader."NP Cancelled" := false;
        PurchHeader."NP Cancel Reason" := '';
        PurchHeader."NP Cancel Reason Description" := '';
        PurchHeader."NP Cancelled By" := '';
        PurchHeader."NP Cancelled On" := 0D;
        PurchHeader."NP Related Order No" := '';
        PurchHeader.Modify();
        CancelledPurchaseLines.SetRange("Purchase Order No.", PurchaseHeader."No.");
        if CancelledPurchaseLines.FindSet() then
            repeat
                PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
                PurchaseLine.SetRange("Document No.", PurchHeader."No.");
                PurchaseLine.SetRange("Line No.", CancelledPurchaseLines."Purchase Line No.");
                if PurchaseLine.FindFirst() then begin
                    PurchaseLine.Validate(Quantity, CancelledPurchaseLines.Quantity);
                    PurchaseLine."NP Cancel Reason" := '';
                    PurchaseLine."NP Cancel Reason Description" := '';
                    PurchaseLine."NP Cancelled By" := '';
                    PurchaseLine."NP Cancelled On" := 0D;
                    PurchaseLine.Modify();
                end;
                CancelledPurchaseLines."Cancel Restored" := true;
                CancelledPurchaseLines."Restored By" := UserId;
                CancelledPurchaseLines."Restored On" := Today;
                CancelledPurchaseLines."NP Related Order No" := '';
                CancelledPurchaseLines.Modify();
            until CancelledPurchaseLines.Next() = 0;
    end;

}
