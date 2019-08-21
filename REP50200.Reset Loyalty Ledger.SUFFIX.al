report 50249 "Reset Loyalty Ledger"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Invoices; "Sales Invoice Header")
        {
            trigger OnPreDataItem()
            begin
                if not loyalLedger.isempty then
                    loyalLedger.deleteAll();
                SetAutoCalcFields("Amount Including VAT");
            end;

            trigger OnAfterGetRecord()
            begin
                loyalMgmt.AddLoyaltyPoints("Sell-to Contact No.", "no.", "Posting Date", "Amount Including VAT");
            end;
        }
    }

    trigger OnPostReport()
    begin
        Message('Loyalty Ledger Reset');
    end;

    var
        loyalLedger: Record "Loyalty Ledger.SUFFIX";
        loyalMgmt: Codeunit "Loyalty Mgmt";
}