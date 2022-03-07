codeunit 50206 "NP Direct Delivery Mgmnt"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure CreateDirectDeliveryJournal(var PurchaseHeader: Record "Purchase Header")
    var
        ItemJournalLine: Record "Item Journal Line";
        JnlLinePost: Codeunit "Item Jnl.-Post";
        PurchaseLine: Record "Purchase Line";
        LineNo: Integer;
        PurchPaySetup: Record "Purchases & Payables Setup";
        TemplateName: Label 'ITEM';
    begin
        PurchPaySetup.Get();
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;
        if PurchaseHeader.Receive then begin
            LineNo := 0;
            ItemJournalLine.SetRange("Journal Template Name", TemplateName);
            ItemJournalLine.SetRange("Journal Batch Name", PurchPaySetup."NP Direct Delivery Journal");
            ItemJournalLine.DeleteAll();
            PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchaseLine.SetRange("NP Direct to Contract", true);
            if PurchaseLine.findset then
                repeat
                    ItemJournalLine.Init();
                    ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
                    ItemJournalLine."Document No." := PurchaseLine."Document No.";
                    ItemJournalLine."Posting Date" := PurchaseHeader."Posting Date";
                    LineNo := LineNo + 10000;
                    ItemJournalLine."Line No." := LineNo;
                    ItemJournalLine.Validate("Journal Template Name", TemplateName);
                    ItemJournalLine.Validate("Journal Batch Name", PurchPaySetup."NP Direct Delivery Journal");
                    ItemJournalLine.Validate("Item No.", PurchaseLine."No.");
                    ItemJournalLine.Validate(Quantity, PurchaseLine."Qty. to Receive");
                    ItemJournalLine.Validate("Location Code", PurchaseLine."Location Code");
                    ItemJournalLine.Validate("Shortcut Dimension 1 Code", PurchaseLine."Shortcut Dimension 1 Code");
                    ItemJournalLine.Validate("Shortcut Dimension 2 Code", PurchaseLine."Shortcut Dimension 2 Code");
                    ItemJournalLine.Insert();
                until PurchaseLine.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure ProcessDirectDelivery(var PurchaseHeader: Record "Purchase Header")
    var
        ItemJournalLine: Record "Item Journal Line";
        JnlLinePost: Codeunit "Item Jnl.-Post line";
        PurchaseLine: Record "Purchase Line";
        PurchPaySetup: Record "Purchases & Payables Setup";
        TemplateName: Label 'ITEM';
    begin
        PurchPaySetup.Get();
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;
        if PurchaseHeader.Receive then begin
            ItemJournalLine.SetRange("Journal Template Name", TemplateName);
            ItemJournalLine.SetRange("Journal Batch Name", PurchPaySetup."NP Direct Delivery Journal");
            if ItemJournalLine.FindFirst() then
                JnlLinePost.Run(ItemJournalLine);
        end;
    end;
}
