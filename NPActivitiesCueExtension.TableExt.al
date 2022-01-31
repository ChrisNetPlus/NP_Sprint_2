tableextension 50008 "NP Activities Cue Extension" extends "Activities Cue"
{
    fields
    {
        field(50003; "NP Open Sales Credit Memos"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Credit Memo"),
                                                      Status = FILTER(Open)));
            Caption = 'Open Sales Credit Memos';
            Editable = false;
            FieldClass = FlowField;

        }
        field(50004; "NP Open Purchase Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Status = FILTER(Released),
                                                         "Completely Received" = FILTER(false)));
            Caption = 'Outstanding Purchase Orders';
            Editable = false;
            FieldClass = FlowField;

        }
    }
}
