tableextension 50032 "NP Purch. Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50100; "NP Direct to Contract"; Boolean)
        {
            Caption = 'Direct to Contract';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ContractError: Label 'You must enter a Contract Code first';
            begin
                if "Shortcut Dimension 1 Code" = '' then
                    Error(ContractError);
            end;
        }
    }
}
