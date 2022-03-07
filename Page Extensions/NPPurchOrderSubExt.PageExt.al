pageextension 50056 "NP Purch. Order Sub Ext" extends "Purchase Order Subform"
{
    layout
    {
        addbefore("Shortcut Dimension 1 Code")
        {
            field("NP Direct to Contract"; Rec."NP Direct to Contract")
            {
                Caption = 'Direct to Contract';
                ToolTip = 'Tick if you are delivering direct to contract';
                ApplicationArea = All;
                Visible = true;
                Editable = false;
            }
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                Item.Get(Rec."No.");
                if Item.Type = Item.Type::Inventory then begin
                    if Rec."Location Code" = '99' then
                        Rec.Validate("NP Direct to Contract", true)
                    else
                        Rec.Validate("NP Direct to Contract", false);
                end;
            end;
        }
    }
}
