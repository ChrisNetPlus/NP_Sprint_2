codeunit 50206 "NP Direct Delivery Mgmnt"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure CreateDirectDeliveryJournal(var PurchaseHeader: Record "Purchase Header")
    var
        ItemJournalLine: Record "Item Journal Line";
        JnlLinePost: Codeunit "Item Jnl.-Post";
        PurchaseLine: Record "Purchase Line";
        LineNo: Integer;
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;
        if PurchaseHeader.Receive then begin
            LineNo := 0;
            ItemJournalLine.SetRange("Journal Template Name", 'ITEM');
            ItemJournalLine.SetRange("Journal Batch Name", 'AUTOPOST');
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
                    ItemJournalLine.Validate("Journal Template Name", 'ITEM');
                    ItemJournalLine.Validate("Journal Batch Name", 'AUTOPOST');
                    ItemJournalLine.Validate("Item No.", PurchaseLine."No.");
                    ItemJournalLine.Validate(Quantity, PurchaseLine."Qty. to Receive");
                    ItemJournalLine.Validate("Location Code", PurchaseLine."Location Code");
                    ItemJournalLine.Validate("Shortcut Dimension 1 Code", PurchaseLine."Shortcut Dimension 1 Code");
                    ItemJournalLine.Validate("Shortcut Dimension 2 Code", PurchaseLine."Shortcut Dimension 2 Code");
                    ItemJournalLine.Insert();//
                until PurchaseLine.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure ProcessDirectDelivery(var PurchaseHeader: Record "Purchase Header")
    var
        ItemJournalLine: Record "Item Journal Line";
        JnlLinePost: Codeunit "Item Jnl.-Post";
        PurchaseLine: Record "Purchase Line";
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;
        if PurchaseHeader.Receive then begin
            ItemJournalLine.SetRange("Journal Template Name", 'ITEM');
            ItemJournalLine.SetRange("Journal Batch Name", 'AUTOPOST');
            if ItemJournalLine.FindFirst() then
                JnlLinePost.Run(ItemJournalLine);
        end;
    end;
}
