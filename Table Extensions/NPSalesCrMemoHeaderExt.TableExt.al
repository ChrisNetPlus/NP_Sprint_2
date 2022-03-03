tableextension 50030 "NP Sales Cr. Memo Header Ext" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50000; "NP Credit Controller"; Code[20])
        {
            Caption = 'Credit Controller';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."NP Credit Controller" where("No." = field("Sell-to Customer No.")));
        }
    }
}
