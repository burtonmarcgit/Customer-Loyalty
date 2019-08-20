tableextension 50201 "Sales Header" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50200; "loyaltyStatus"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Bronze,Silver,Gold;
            Caption = 'Loyalty Status';
            Editable = false;
        }
    }
}
tableextension 50202 "Sales Invoce Header" extends "Sales Invoice Header"
{
    fields
    {
        // Add changes to table fields here
        field(50200; "LoyaltyStatus"; option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Bronze,Silver,Gold;
            Caption = 'Loalty Status';
            Editable = false
        }

    }
}

pageextension 50201 "Sales Order" extends "Sales Order"

{
    layout
    {
        addlast(General)
        {
            field("loyaltyStatus"; "loyaltyStatus") { }

        }
    }
}

pageextension 50202 "Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("loytyStatus"; "loyaltyStatus") { }
        }
    }
}