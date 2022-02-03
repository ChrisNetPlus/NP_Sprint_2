page 50004 "NP Cancel Reasons"
{
    Caption = 'Cancel Reasons';
    PageType = List;
    SourceTable = "NP Order Cancel Reason";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the value of the Reason Code field.';
                    ApplicationArea = All;
                    Caption = 'Reason Code';
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ToolTip = 'Specifies the value of the Reason Description field.';
                    ApplicationArea = All;
                    Caption = 'Description';
                }
            }
        }
    }
}
