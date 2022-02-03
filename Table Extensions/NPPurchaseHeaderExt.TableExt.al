tableextension 50019 "NP Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(50003; "NP Cancelled"; Boolean)
        {
            Caption = 'Cancelled';
            DataClassification = CustomerContent;
        }
        field(50004; "NP Cancelled By"; Code[50])
        {
            Caption = 'Cancelled By';
            DataClassification = CustomerContent;
        }
        field(50005; "NP Cancelled On"; Date)
        {
            Caption = 'Cancelled On';
            DataClassification = CustomerContent;
        }
        field(50006; "NP Cancel Reason"; Code[30])
        {
            Caption = 'Cancel Reason';
            DataClassification = CustomerContent;
            TableRelation = "NP Order Cancel Reason"."Reason Code";
            trigger OnValidate()
            var
                NPOrderCancelReason: Record "NP Order Cancel Reason";
            begin
                if NPOrderCancelReason.Get("NP Cancel Reason") then
                    "NP Cancel Reason Description" := NPOrderCancelReason."Reason Description"
                else
                    "NP Cancel Reason Description" := '';
            end;
        }
        field(50007; "NP Cancel Reason Description"; Text[100])
        {
            Caption = 'Cancel Reason Description';
            DataClassification = CustomerContent;

        }
        field(50008; "NP Related Order No"; Text[100])
        {
            Caption = 'Related Order Numbers';
            DataClassification = CustomerContent;
        }
    }
}
