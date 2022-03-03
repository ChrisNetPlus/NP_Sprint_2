tableextension 50028 "NP Sales Header Ext" extends "Sales Header"
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
