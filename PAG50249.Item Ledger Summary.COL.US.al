page 50249 "Item Ledger Summary.COL.US"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Ledger Entry";
    SourceTableTemporary = true;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(summarizedDataRepeater)
            {
                field("Location Code"; "Location Code") { }
                field("Item No."; "Item No.") { }
                field("Unit of Measure Code"; "Unit of Measure Code") { }
                field("Lot No."; "Lot No.") { }
                field(Quantity; Quantity) { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(loopSummary)
            {
                ApplicationArea = All;
                Caption = 'Summarize by Loop';
                trigger OnAction();
                begin
                    ClearData();
                    AddExtraData();
                    SummaryLoop();

                end;
            }
            action(querySummary)
            {
                ApplicationArea = All;
                Caption = 'Summarize by Query';
                trigger OnAction();
                begin
                    ClearData();
                    AddExtraData();
                    SummaryQuery();
                end;
            }
        }
    }

    local procedure ClearData()
    begin
        Clear(Rec);
        IF not IsEmpty then
            DeleteAll();
    end;

    local procedure AddExtraData()
    var
        ile: Record "Item Ledger Entry";
        ile2: Record "Item Ledger Entry";
        i: Integer;
        ent: Integer;
        window: Dialog;
        t: Integer;
        c: Integer;
    begin
        ile.SetRange("Source No.", 'DELETE_ME');
        if not ile.IsEmpty then
            exit;
        ile.SetRange("Source No.");
        ile.FindLast();
        ile.SetFilter("Entry No.", StrSubstNo('<=%1', ile."Entry No."));
        window.Open('Adding additional temporary data #1## of 100');
        ent := ile."Entry No.";
        for i := 1 to 100 do begin
            if ile.FindSet() then
                repeat
                    window.Update(1, i);
                    ile2 := ile;
                    ent += 1;
                    ile2."Entry No." := ent;
                    ile2."Source No." := 'DELETE_ME';
                    ile2.Insert();
                until ile.Next() = 0;
        end;
        window.Close();
    end;

    trigger OnClosePage()
    begin
        RemoveExtraData();
    end;

    local procedure RemoveExtraData()
    var
        ile: Record "Item Ledger Entry";
    begin
        ile.SetRange("Source No.", 'DELETE_ME');
        ile.DeleteAll();
    end;

    local procedure SummaryLoop()
    var
        st: DateTime;
        et: DateTime;
        ent: Integer;
        ile: Record "Item Ledger Entry";

    begin
        st := CurrentDateTime;
        if ile.FindSet() then
            repeat
                SetRange("Location Code", ile."Location Code");
                SetRange("Item No.", ile."Item No.");
                SetRange("Unit of Measure Code", ile."Unit of Measure Code");
                SetRange("Lot No.", ile."Lot No.");
                if not FindFirst() then begin
                    init;
                    ent += 1;
                    "Entry No." := ent;
                    "Location Code" := ile."Location Code";
                    "Item No." := ile."Item No.";
                    "Unit of Measure Code" := ile."Unit of Measure Code";
                    "Lot No." := ile."Lot No.";
                    insert;
                end;
                Quantity += ile.Quantity;
                Modify();
            until ile.next = 0;
        et := CurrentDateTime;
        clear(Rec);
        Message('Summary took %1', et - st);
    end;

    local procedure SummaryQuery()
    var
        st: DateTime;
        et: DateTime;
        ent: Integer;
        //qry : Query "Summarize ILE.SUFFIX";          
    begin
        st := CurrentDateTime;

        if qry.Open() then begin
            while qry.Read() do begin
                ent += 1;
                Init();
                "Entry No." := ent;
                "Location Code" := qry.Location_Code;
                "Item No." := qry.Item_No_;
                "Unit of Measure Code" := qry.Unit_of_Measure_Code;
                "Lot No." := qry.Lot_No_;
                Quantity := qry.Quantity;
                Insert();
            end;
            qry.Close();
        end;

        et := CurrentDateTime;
        Message('Summary took %1', et - st);
    end;
}