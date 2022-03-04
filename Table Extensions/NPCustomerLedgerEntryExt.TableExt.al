tableextension 50031 "NP Customer Ledger Entry Ext" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "NP Credit Controller"; Code[20])
        {
            Caption = 'Credit Controller';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."NP Credit Controller" where("No." = field("Customer No.")));
            Editable = false;
        }
    }
}
