xmlport 50200 "Export Loyalty Data"
{
    UseRequestPage = false;
    Direction = Export;
    Format = Xml;

    schema
    {
        textelement(NodeName1)
        {
            tableelement(Ledger; "Loyalty Ledger.SUFFIX")
            {
                fieldattribute(CustNo; ledger."Customer No") { }
                fieldattribute(DocNo; ledger."Document No") { }
                fieldattribute(postdate; ledger."Posting Date") { }
                fieldattribute(points; ledger."Points Earned") { }
            }
        }
    }
}