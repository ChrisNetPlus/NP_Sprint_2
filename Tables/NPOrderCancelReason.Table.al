table 50003 "NP Order Cancel Reason"
{
    Caption = 'Order Cancel Reason';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Reason Code"; Code[30])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
        }
        field(2; "Reason Description"; Text[100])
        {
            Caption = 'Reason Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Reason Code")
        {
            Clustered = true;
        }
    }
}
