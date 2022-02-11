tableextension 50011 "NP New User Setup Ext" extends "User Setup"
{
    fields
    {
        field(50010; "NP Disallow PO Invoice"; Boolean)
        {
            Caption = 'Disallow PO Invoice';
            DataClassification = CustomerContent;
        }
        field(50011; "NP Depot Worker"; Boolean)
        {
            Caption = 'Deport Worker';
            DataClassification = CustomerContent;
        }
    }
}
