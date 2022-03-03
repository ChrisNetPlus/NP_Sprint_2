tableextension 50029 "NP Sales Invoice Header Ext" extends "Sales Invoice Header"
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
