pageextension 50033 "NP PurchaseOrderExt" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("NP Cancelled"; Rec."NP Cancelled")
            {
                Caption = 'Cancelled';
                ToolTip = 'Cancelled';
                ApplicationArea = All;
                Editable = false;
                Visible = EnableCancel;
            }
            field("NP Cancel Reason"; Rec."NP Cancel Reason")
            {
                Caption = 'Cancel Reason';
                ToolTip = 'Cancel Reason';
                ApplicationArea = All;
                Visible = EnableCancel;
            }
            field("NP Cancel Reason Description"; Rec."NP Cancel Reason Description")
            {
                Caption = 'Cancel Description';
                ToolTip = 'Cancel Description';
                ApplicationArea = All;
                Editable = false;
                Visible = EnableCancel;
            }
            field("NP Related Order No"; Rec."NP Related Order No")
            {
                Caption = 'Related Order No.';
                ToolTip = 'Related Order No.';
                ApplicationArea = All;
                Visible = EnableCancel;
            }
            field("NP Value Held"; Rec."NP Value Held")
            {
                Caption = 'Value Held';
                ToolTip = 'Value Held';
                ApplicationArea = All;
                Editable = false;
            }
            field("NP Value Approved"; Rec."NP Value Approved")
            {
                Caption = 'Value Approved';
                ToolTip = 'Value Approved';
                ApplicationArea = All;
                Editable = false;
            }

        }
    }
    actions
    {
        addafter("Create Inventor&y Put-away/Pick")
        {
            action("NP Cancel Order")
            {
                Image = Cancel;
                Caption = 'Cancel Order';
                ToolTip = 'This will cancel the purchase order';
                ApplicationArea = All;
                Promoted = true;
                Visible = EnableCancel;

                trigger OnAction()
                var
                    OrderCancelCU: Codeunit "NP PurchaseOrderCancelling";
                    ConfirmLabel: Label 'Are you sure you want to cancel this order?';
                begin
                    if Confirm(ConfirmLabel, false) then
                        OrderCancelCU.CancelPurchaseOrder(Rec);
                end;
            }
            action("NP UnCancel Order")
            {
                Image = Restore;
                Caption = 'Uncancel Order';
                ToolTip = 'This will uncancel the purchase order';
                ApplicationArea = All;
                Promoted = true;
                Visible = EnableCancel;

                trigger OnAction()
                var
                    OrderCancelCU: Codeunit "NP PurchaseOrderCancelling";
                    ConfirmLabel: Label 'Are you sure you want to uncancel this order?';
                begin
                    if Confirm(ConfirmLabel, false) then
                        OrderCancelCU.UnCancelPurchaseOrder(Rec);
                end;
            }
            action("NP Approve Value")
            {
                Image = Approval;
                Caption = 'Approve Value';
                ToolTip = 'This will the purchase order';
                ApplicationArea = All;
                Promoted = true;
                Visible = true;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    NotAllowed: Label 'You are not allowed to approve an order';
                begin
                    UserSetup.Get(UserId);
                    if UserSetup."Unlimited Purchase Approval" then begin
                        Rec."NP Value Approved" := true;
                        Rec."NP Value Held" := false;
                        Rec.Modify();
                    end else
                        Error(NotAllowed);
                end;
            }

        }
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                AlreadyCancelled: Label 'This Order is Cancelled';
            begin
                if Rec."NP Cancelled" then
                    Error(AlreadyCancelled);
            end;
        }
        modify(Print)
        {
            Visible = EnablePrint;
        }
        modify("&Print")
        {
            Visible = EnablePrint;
        }
        modify(AttachAsPDF)
        {
            Visible = EnablePrint;
        }
        modify(SendCustom)
        {
            Visible = EnablePrint;
        }
    }
    trigger OnOpenPage()
    var
        PurchPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchPayablesSetup.Get();
        if PurchPayablesSetup."Enable PO Cancelling" then
            EnableCancel := true;
        if PurchPayablesSetup."NP Disallow PO Print" then begin
            if Rec.Status <> Rec.Status::Released then
                EnablePrint := false
            else
                EnablePrint := true;
        end;
    end;

    var
        EnableCancel: Boolean;
        EnablePrint: Boolean;

    trigger OnDeleteRecord() DeleteRecord: Boolean
    var
        PurchPayablesSetup: Record "Purchases & Payables Setup";
        DeleteError: Label 'You cannot delete an order - please use the Cancel option';
    begin
        PurchPayablesSetup.Get();
        if not PurchPayablesSetup."Enable PO Cancelling" then
            exit else
            Error(DeleteError);
    end;
}
