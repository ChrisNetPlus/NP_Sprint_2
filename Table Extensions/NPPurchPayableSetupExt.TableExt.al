tableextension 50033 "NP Purch. Payable Setup Ext" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50101; "NP Direct Delivery Journal"; Code[20])
        {
            Caption = 'Direct Delivery Journal';
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = const('ITEM'));
        }
    }
}
