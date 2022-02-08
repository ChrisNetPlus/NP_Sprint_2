tableextension 50023 "NP Customer Ext" extends Customer
{
    fields
    {
        field(50003; "NP Customer Registration No."; Code[20])
        {
            Caption = 'Customer Registration No.';
            DataClassification = CustomerContent;
        }
        field(50004; "NP UTR Number"; Code[20])
        {
            Caption = 'UTR Number';
            DataClassification = CustomerContent;
        }
    }
}
