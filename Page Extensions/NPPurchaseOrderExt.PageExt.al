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
            }
            field("NP Cancel Reason"; Rec."NP Cancel Reason")
            {
                Caption = 'Cancel Reason';
                ToolTip = 'Cancel Reason';
                ApplicationArea = All;
            }
            field("NP Cancel Reason Description"; Rec."NP Cancel Reason Description")
            {
                Caption = 'Cancel Description';
                ToolTip = 'Cancel Description';
                ApplicationArea = All;
                Editable = false;
            }
            field("NP Related Order No"; Rec."NP Related Order No")
            {
                Caption = 'Related Order No.';
                ToolTip = 'Related Order No.';
                ApplicationArea = All;
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

                trigger OnAction()
                var
                    OrderCancelCU: Codeunit "NP PurchaseOrderCancelling";
                    ConfirmLabel: Label 'Are you sure you want to uncancel this order?';
                begin
                    if Confirm(ConfirmLabel, false) then
                        OrderCancelCU.UnCancelPurchaseOrder(Rec);
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
    }
}
