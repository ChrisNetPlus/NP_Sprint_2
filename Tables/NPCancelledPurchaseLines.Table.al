table 50004 "NP Cancelled Purchase Lines"
{
    Caption = 'Cancelled Purchase Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Purchase Line No."; Integer)
        {
            Caption = 'Purchase Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Item No."; Code[50])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(5; "Cancelled By"; Code[50])
        {
            Caption = 'Cancelled By';
            DataClassification = ToBeClassified;
        }
        field(6; "Cancelled On"; Date)
        {
            Caption = 'Cancelled On';
            DataClassification = ToBeClassified;
        }
        field(7; "Cancel Reason Code"; Code[30])
        {
            Caption = 'Cancel Reason Code';
            DataClassification = ToBeClassified;
        }
        field(8; "Cancel Reason Description"; Text[100])
        {
            Caption = 'Cancel Reason Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Cancel Restored"; Boolean)
        {
            Caption = 'Cancel Restored';
            DataClassification = ToBeClassified;
        }
        field(10; "Restored By"; Code[50])
        {
            Caption = 'Restored By';
            DataClassification = ToBeClassified;
        }
        field(11; "Restored On"; Date)
        {
            Caption = 'Restored On';
            DataClassification = ToBeClassified;
        }
        field(12; "NP Related Order No"; Text[100])
        {
            Caption = 'Related Order Numbers';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Purchase Order No.", "Purchase Line No.")
        {
            Clustered = true;
        }
    }
}
