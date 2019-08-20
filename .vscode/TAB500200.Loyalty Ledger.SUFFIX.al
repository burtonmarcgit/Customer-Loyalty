table 50200 "Loyalty Ledger.SUFFIX"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; bigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No';
            AutoIncrement = true;


        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';

        }
        field(3; "Customer No"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No';
            TableRelation = customer."No.";

        }
        field(4; "Document No"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No';
            TableRelation = "Sales Invoice Header"."No.";

        }
        field(5; "Points Earned"; bigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'Points Earned';

        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
        key(custdoc; "Customer No", "Document No") { }
        key(custdate; "Customer No", "Posting Date") { }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}