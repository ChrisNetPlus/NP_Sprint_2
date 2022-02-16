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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure CheckUserPostPermission(var HideDialog: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        UserSetup: Record "User Setup";
        ReceiveLabel: Label 'Receive?';
        ReceiveError: Label 'Receipt Cancelled';
        WarehouseEmployee: Record "Warehouse Employee";
        WrongLocation: Label 'This location is not allowed for your user';
        PurchaseLine: Record "Purchase Line";
    begin
        if not UserSetup.Get(UserId) then
            exit;
        if UserSetup."NP Depot Worker" then begin
            PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
            if PurchaseLine.FindSet() then
                repeat
                    WarehouseEmployee.SetRange("User ID", UserId);
                    WarehouseEmployee.SetRange("Location Code", PurchaseLine."Location Code");
                    if not WarehouseEmployee.FindFirst() then
                        Error(WrongLocation);
                until PurchaseLine.Next = 0;
            CheckUserPurchaseLimit(PurchaseHeader);
        end;

        if UserSetup."NP Disallow PO Invoice" then begin
            HideDialog := true;
            PurchaseHeader.Invoice := false;
            if not Confirm(ReceiveLabel, true) then
                Error(ReceiveError)
            else
                PurchaseHeader.Receive := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterValidateEvent', 'Location Code', false, false)]
    local procedure CheckAllowedLocations(var Rec: Record "Item Journal Line")
    var
        WarehouseEmployee: Record "Warehouse Employee";
        UserSetup: Record "User Setup";
        WrongLocation: Label 'This location is not allowed for your user';
    begin
        UserSetup.Get(UserId);
        if UserSetup."NP Depot Worker" then begin
            WarehouseEmployee.SetRange("User ID", UserId);
            WarehouseEmployee.SetRange("Location Code", Rec."Location Code");
            if not WarehouseEmployee.FindFirst() then
                Error(WrongLocation);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeManualReleasePurchaseDoc', '', false, false)]
    local procedure CheckUserPurchaseLimit(var PurchaseHeader: Record "Purchase Header")
    var
        ApprovalUser: Record "User Setup";
        AprovalSetupError: Label 'User must have a Purchase Amount Approval Limit setup in Approval User Setup';
        AboveLimtError: Label 'The value of this order exceeds the allowed amount of %1';
    begin
        if ApprovalUser.Get(UserId) then begin
            if ApprovalUser."Purchase Amount Approval Limit" = 0 then
                Error(AprovalSetupError);
            PurchaseHeader.CalcFields(Amount);
            if PurchaseHeader.Amount > ApprovalUser."Purchase Amount Approval Limit" then begin
                if not PurchaseHeader."NP Value Approved" then begin
                    PurchaseHeader."NP Value Held" := true;
                    PurchaseHeader."NP Value Approved" := false;
                    PurchaseHeader.Modify();
                    Commit();
                    Error(AboveLimtError, ApprovalUser."Purchase Amount Approval Limit");
                end else
                    exit;
            end else begin
                PurchaseHeader."NP Value Approved" := true;
                PurchaseHeader."NP Value Held" := false;
                PurchaseHeader.Modify();
                Commit();
            end;

        end;
    end;

}
