codeunit 50201 "Loyalty Mgmt"
{
    procedure AddLoyaltyPoints(CustCode: Code[20]; docNo: Code[20]; postDate: Date; invAmt: Decimal)
    var
        ledger: Record "Loyalty Ledger.SUFFIX";
    begin
        ledger."Customer No" := CustCode;
        ledger."Document No" := docNo;
        ledger."Posting Date" := postDate;
        // 1 Point for every 5 dollars spent 
        ledger."Points Earned" := invAmt;
        ledger.Insert(true);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, false)]
    local procedure MyProcedure(VAR SalesHeader: Record "Sales Header"; VAR GENJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean)

    var
        loyaltyMgmt: Codeunit "Loyalty Mgmt";
        salesInvHeader: Record "Sales Invoice Header";
    begin
        if salesInvHeader.get(SalesInvHdrNo) then begin
            salesInvHeader.CalcFields("Amount Including VAT");
            loyaltyMgmt.AddLoyaltyPoints(salesInvHeader."Sell-to Customer No.", salesInvHeader."No.", salesInvHeader."Posting Date", salesInvHeader."Amount Including VAT");
        end;
    end;

}