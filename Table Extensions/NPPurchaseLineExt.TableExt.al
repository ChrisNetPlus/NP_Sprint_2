tableextension 50021 "NP PurchaseLineExt" extends "Purchase Line"
{
    fields
    {
        field(50010; "NP Cancelled"; Boolean)
        {
            Caption = 'Cancelled';
            ObsoleteState = Removed;
            ObsoleteReason = 'Removed';
        }
        field(50011; "NP Cancelled By"; Code[50])
        {
            Caption = 'Cancelled By';
            DataClassification = CustomerContent;
        }
        field(50012; "NP Cancelled On"; Date)
        {
            Caption = 'Cancelled On';
            DataClassification = CustomerContent;
        }
        field(50013; "NP Cancel Reason"; Code[30])
        {
            Caption = 'Cancel Reason';
            DataClassification = CustomerContent;
        }
        field(50014; "NP Cancel Reason Description"; Text[100])
        {
            Caption = 'Cancel Reason Description';
            DataClassification = CustomerContent;
        }
        field(50015; "NP Cancelled Order"; Boolean)
        {
            Caption = 'Cancelled';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."NP Cancelled" where("No." = field("Document No.")));
        }

    }
}
