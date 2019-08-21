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
        ledger.Insert(true)

    end;

    var
        myInt: Integer;
}