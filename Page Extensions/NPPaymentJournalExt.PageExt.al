pageextension 50043 "NP Payment Journal Ext" extends "Payment Journal"
{
    actions
    {
        addafter("NP New BACS Export")
        {
            action("NP Correct CIS")
            {
                Image = UpdateDescription;
                Caption = 'Correct CIS';
                ToolTip = 'This will correct the CIS info';
                ApplicationArea = All;
                Promoted = true;
                Visible = true;

                trigger OnAction()
                begin
                    UpdateCISAmount(Rec);
                end;
            }
        }
    }
    local procedure UpdateCISAmount(var Rec: Record "Gen. Journal Line")
    var
        JournalType: Label 'PAYMENTS';
        Vendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CISGrossAmount: Decimal;
        VATEntry: Record "VAT Entry";
        AmountExcVAT: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
    begin
        Clear(CISGrossAmount);
        if Rec."Journal Template Name" <> JournalType then
            exit;
        if Rec."Account Type" <> Rec."Account Type"::Vendor then
            exit;
        GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        if GenJournalLine.FindSet() then
            repeat
                Clear(CISGrossAmount);
                Clear(AmountExcVAT);
                Vendor.Get(GenJournalLine."Account No.");
                if Vendor."CIS Include on CIS Return" then begin
                    if Vendor."CIS Withholding Tax Rate" = 0 then begin
                        VendorLedgerEntry.SetRange("Applies-to ID", GenJournalLine."Applies-to ID");
                        if VendorLedgerEntry.FindSet() then
                            repeat
                                VATEntry.Reset();
                                VATEntry.SetRange("Document No.", VendorLedgerEntry."Document No.");
                                if VATEntry.FindSet() then
                                    repeat
                                        AmountExcVAT := AmountExcVAT + VATEntry.Base;
                                    until VATEntry.Next() = 0;
                                CISGrossAmount += AmountExcVAT;
                            until VendorLedgerEntry.Next() = 0;
                    end else begin
                        VendorLedgerEntry.SetRange("Applies-to ID", GenJournalLine."Applies-to ID");
                        if VendorLedgerEntry.FindSet() then
                            repeat
                                VendorLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                                CISGrossAmount := Abs(VendorLedgerEntry."Remaining Amt. (LCY)") - GenJournalLine."CIS Withheld Tax Amount";
                            until VendorLedgerEntry.Next() = 0;
                    end;
                    if GenJournalLine."Applies-to ID" <> '' then
                        GenJournalLine.Validate("CIS Gross Amount", CISGrossAmount);
                    GenJournalLine.Modify();
                end;
            until GenJournalLine.Next() = 0;
    end;

}
