pageextension 50044 "NP CIS Tax Return Ext" extends "CIS Tax Return Card"
{
    actions
    {
        addafter(SuggestLines)
        {
            action("NP Update Lines")
            {
                Image = UpdateDescription;
                Caption = 'Update Lines';
                ToolTip = 'This will correct the CIS info';
                ApplicationArea = All;
                Promoted = true;
                Visible = true;

                trigger OnAction()
                var
                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                    LinkedVendorLedgerEntry: Record "Vendor Ledger Entry";
                    VATEntry: Record "VAT Entry";
                    CISDtVendLedgEntry: Record "CIS Dt Vendor Ledger Entry";
                    CISTaxReturnLine: Record "CIS Tax Return Line";
                    PreVATTotal: Decimal;
                    NonVATEntries: Decimal;
                    Vendor: Record Vendor;
                begin
                    CISTaxReturnLine.SetRange("CIS Tax Return No.", Rec."CIS No.");
                    if CISTaxReturnLine.FindSet() then
                        repeat
                            Clear(PreVATTotal);
                            Clear(NonVATEntries);
                            Vendor.Get(CISTaxReturnLine."CIS Vendor No.");
                            if Vendor."CIS Withholding Tax Rate" <> 0 then begin
                                CISDtVendLedgEntry.Reset();
                                CISDtVendLedgEntry.SetRange("CIS Tax Return No.", CISTaxReturnLine."CIS Tax Return No.");
                                CISDtVendLedgEntry.SetRange("Vendor No.", CISTaxReturnLine."CIS Vendor No.");
                                CISDtVendLedgEntry.SetRange("Document Type", CISDtVendLedgEntry."Document Type"::Payment);
                                if CISDtVendLedgEntry.FindSet() then
                                    repeat
                                        LinkedVendorLedgerEntry.Reset();
                                        LinkedVendorLedgerEntry.SetRange("Entry No.", CISDtVendLedgEntry."Vendor Ledger Entry No.");
                                        if LinkedVendorLedgerEntry.FindFirst() then begin
                                            VendorLedgerEntry.SetRange("Entry No.", LinkedVendorLedgerEntry."Closed by Entry No.");
                                            if VendorLedgerEntry.FindFirst() then begin
                                                VATEntry.Reset();
                                                VATEntry.SetRange("Document No.", VendorLedgerEntry."Document No.");
                                                if VATEntry.FindSet() then
                                                    repeat
                                                        PreVATTotal += VATEntry.Base;
                                                    until VATEntry.Next() = 0;
                                            end;
                                        end;
                                    until CISDtVendLedgEntry.Next() = 0;
                                CISDtVendLedgEntry.Reset();
                                CISDtVendLedgEntry.SetRange("CIS Tax Return No.", CISTaxReturnLine."CIS Tax Return No.");
                                CISDtVendLedgEntry.SetRange("Vendor No.", CISTaxReturnLine."CIS Vendor No.");
                                CISDtVendLedgEntry.SetRange("Document Type", CISDtVendLedgEntry."Document Type"::" ");
                                if CISDtVendLedgEntry.FindSet() then
                                    repeat
                                        NonVATEntries += CISDtVendLedgEntry."Amount (LCY)";
                                    until CISDtVendLedgEntry.Next() = 0;

                                CISTaxReturnLine."CIS Total Payment" := PreVATTotal + NonVATEntries;
                                CISTaxReturnLine.Modify();
                            end;
                        until CISTaxReturnLine.Next() = 0;
                end;
            }
        }
    }
}
