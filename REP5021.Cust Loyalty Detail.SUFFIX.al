report 50201 "Cust Loyalty Detail"
{
    Caption = 'Customer Loyalty Detail';
    DefaultLayout = RDLC;
    RDLCLayout = '.\Resources\REP50201.Cust Loyalty Detail.rdl';


    dataset
    {
        dataitem(cust; Customer)
        {
            column(custno; "No.") { }
            column(custname; Name) { }
            dataitem(ledger; "Loyalty Ledger.SUFFIX")
            {
                DataItemLink = "Customer No" = field ("No.");

                column(Document_No; "Document No") { }
                column("Posting_Date"; "Posting Date") { }
                column("Points_Earned"; "Points Earned") { }
                column("invAmt"; sih."Amount Including VAT") { }

                trigger OnPreDataItem()
                begin
                    sih.SetAutoCalcFields("Amount Including VAT");
                end;

                trigger OnAfterGetRecord()
                begin
                    clear(sih);
                    if sih.get("Document No") then;
                end;
            }
        }

    }

    labels
    {
        cust_LBL = 'Customer';
        DocNo_LBL = 'Document No.';
        Date_LBL = 'Posting Date';
        Amt_LBL = 'Amount';
        Points_LBL = 'Points';
        Title_LBL = 'Customer Loyalty Detail';
    }

    var
        sih: Record "Sales Invoice Header";
}