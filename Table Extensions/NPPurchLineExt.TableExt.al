tableextension 50032 "NP Purch. Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50100; "NP Direct to Contract"; Boolean)
        {
            Caption = 'Direct to Contract';
            DataClassification = CustomerContent;
        }
    }
}
