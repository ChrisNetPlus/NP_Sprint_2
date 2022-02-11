pageextension 50020 "NP Activities Cue Ext" extends "O365 Activities"
{
    layout
    {
        addafter("Ongoing Sales Invoices")
        {
            field("NP Open Sales Credit Memos"; Rec."NP Open Sales Credit Memos")
            {
                Caption = 'Sales Credits';
                ToolTip = 'Specifies sales credits that are not yet posted or only partially posted.';
                DrillDownPageID = "Sales Credit Memos";
                ApplicationArea = Basic, Suite;
            }
            field("NP Customer Job Queue"; Rec."NP Customer Job Queue")
            {
                Caption = 'Cust. Job Queue';
                ToolTip = 'Click her to find the Job Queue Entry to Run for Customer Export';
                DrillDownPageID = "Job Queue Entries";
                ApplicationArea = Basic, Suite;
            }
            field("NP Cancelled POs"; Rec."NP Cancelled POs")
            {
                Caption = 'Cancelled POs';
                ToolTip = 'Click her to find any cancelled purchase orders';
                DrillDownPageID = "NP Cancelled Purchase Orders";
                ApplicationArea = Basic, Suite;

            }
        }
    }
}
