pageextension 50035 "NP Purchase Line List Ext" extends "NP Purchase Line List"
{
    layout
    {
        addafter("Document No.")
        {
            field("NP Cancelled Order"; Rec."NP Cancelled Order")
            {
                Caption = 'Cancelled';
                ToolTip = 'Order has been cancelled';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Related Document")
        {
            action("NP Cancelled Entries")
            {
                Caption = 'Cancelled Entries';
                ToolTip = 'Browse to the Cancelled Entries';
                ApplicationArea = All;
                Image = Info;
                trigger OnAction()
                var
                    CancelledPOEntries: Record "NP Cancelled Purchase Lines";
                begin
                    CancelledPOEntries.SetRange("Purchase Order No.", Rec."Document No.");
                    Page.Run(Page::"NP Cancelled Purchase Orders", CancelledPOEntries);
                end;

            }
        }
    }
}
