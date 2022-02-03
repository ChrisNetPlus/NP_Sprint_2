page 50003 "NP Cancelled Purchase Orders"
{
    ApplicationArea = All;
    Caption = 'Cancelled Purchase Orders';
    PageType = List;
    SourceTable = "NP Cancelled Purchase Lines";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Order No. field.';
                    ApplicationArea = All;
                    Caption = 'Purchase Order No.';
                }
                field("Purchase Line No."; Rec."Purchase Line No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Line No. field.';
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                    Caption = 'Item No.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                    Caption = 'Quantity';
                }
                field("Cancel Reason Code"; Rec."Cancel Reason Code")
                {
                    ToolTip = 'Specifies the value of the Cancel Reason Code field.';
                    ApplicationArea = All;
                    Caption = 'Reason Code';
                }
                field("Cancel Reason Description"; Rec."Cancel Reason Description")
                {
                    ToolTip = 'Specifies the value of the Cancel Reason Description field.';
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                    ToolTip = 'Specifies the value of the Cancelled By field.';
                    ApplicationArea = All;
                    Caption = 'Cancelled By';
                }
                field("Cancelled On"; Rec."Cancelled On")
                {
                    ToolTip = 'Specifies the value of the Cancelled On field.';
                    ApplicationArea = All;
                    Caption = 'Cancelled On';
                }
                field("Cancel Restored"; Rec."Cancel Restored")
                {
                    ToolTip = 'Specifies the value of the Cancel Restored field.';
                    ApplicationArea = All;
                    Caption = 'Restored';
                }
                field("Restored By"; Rec."Restored By")
                {
                    ToolTip = 'Specifies the value of the Restored By field.';
                    ApplicationArea = All;
                    Caption = 'Restored By';
                }
                field("Restored On"; Rec."Restored On")
                {
                    ToolTip = 'Specifies the value of the Restored On field.';
                    ApplicationArea = All;
                    Caption = 'Restored On';
                }
                field("NP Related Order No"; Rec."NP Related Order No")
                {
                    ToolTip = 'Specifies the value of the Related Order Numbers field.';
                    ApplicationArea = All;
                    Caption = 'Related Order No.';

                }
            }
        }
    }
}
