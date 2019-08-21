pageextension 50200 "Customer Card.SUFFIX" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("loyaltyStatus.SUFFIX"; "loyaltyStatus.SUFFIX")
            {
                ApplicationArea = All;

            }
        }

    }

    actions
    {
        // Add changes to page actions here

        addlast(History)
        {
            action(loyalty)
            {
                caption = 'Loyalty Points';
                image = LedgerEntries;
                runobject = page "Loyalty Ledger Entries.SUFFIX";
                runpagelink = "Customer No" = field ("no.");
            }
            action(LoyaltyDetail)
            {
                Caption = 'Loyalty Detailed Report';
                Image = Report;
                trigger OnAction()
                var
                    cust: Record Customer;
                begin
                    cust := rec;
                    cust.SetRecFilter();
                    Report.RunModal(Report::"Cust Loyalty Detail", true, false, cust);
                end;
            }
            action(xmlport)
            {
                caption = 'XML Loyalty Data';
                image = XMLFile;

                trigger OnAction()

                begin
                    xmlport.Run(50200);
                end;
            }
        }
    }

    var
        myInt: Integer;
}

pageextension 50203 "customer List" extends "customer List"
{

    actions
    {
        // Add changes to page actions here
        addlast(History)
        {
            action(Loyalty)
            {
                Caption = 'Loyalty Points';
                Image = LedgerEntries;
                RunObject = page "Loyalty Ledger Entries.SUFFIX";
                RunPageLink = "Customer No" = field ("no.");
            }
            action(LoyaltyDetail)
            {
                Caption = 'Loyalty Detailed Report';
                Image = Report;
                trigger OnAction()
                var
                    cust: Record Customer;
                begin
                    cust := rec;
                    cust.SetRecFilter();5
                    Report.RunModal(Report::"Cust Loyalty Detail", true, false, cust);
                end;
            }
            action(xmlport)
            {
                caption = 'XML Loyalty Data';
                image = XMLFile;

                trigger OnAction()

                begin
                    xmlport.Run(50200);
                end;
            }


        }
    }
}