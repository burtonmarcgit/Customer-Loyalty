codeunit 50200 "Sales Event Mgmt.SUFFIX"
{
    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', true, false)]
    local procedure T_SalesHeader_SellToCustomerNo_OnAfterValidate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)

    var
        cust: Record Customer;

    begin
        if cust.get(rec."Sell-to Customer No.") then
            rec.loyaltyStatus := cust."loyaltyStatus.SUFFIX";
    end;
}