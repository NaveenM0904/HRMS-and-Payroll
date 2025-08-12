codeunit 80001 "HRMS Payroll Processing"

{

    /// <summary> 

    /// Process and post payroll to General Ledger 

    /// </summary> 

    procedure ProcessPayroll(var PayrollHeader: Record "HRMS Payroll Header")

    var

        PayrollLine: Record "HRMS Payroll Line";

        GenJournalLine: Record "Gen. Journal Line";

        PayHead: Record "HRMS Pay Head";

        Employee: Record "HRMS Employee";

        GenJournalBatch: Record "Gen. Journal Batch";

        DocumentNo: Code[20];

        LineNo: Integer;

    begin

        PayrollHeader.TestField(Status, PayrollHeader.Status::"In Progress");



        // Setup journal batch 

        //SetupPayrollJournalBatch(GenJournalBatch);



        // Clear existing journal lines 

        GenJournalLine.SetRange("Journal Template Name", GenJournalBatch."Journal Template Name");

        GenJournalLine.SetRange("Journal Batch Name", GenJournalBatch.Name);

        GenJournalLine.DeleteAll();



        DocumentNo := PayrollHeader."Payroll Period";

        LineNo := 10000;



        // Create journal lines for each pay head 

        PayrollLine.SetRange("Payroll Period", PayrollHeader."Payroll Period");

        if PayrollLine.FindSet() then
            repeat

                PayHead.Get(PayrollLine."Pay Head Code");

                Employee.Get(PayrollLine."Employee No.");



                CreatePayrollJournalLine(

                    GenJournalLine,

                    GenJournalBatch,

                    DocumentNo,

                    LineNo,

                    PayHead,

                    Employee,

                    PayrollLine);



                LineNo += 10000;

            until PayrollLine.Next() = 0;



        // Post journal lines 

        GenJournalLine.SetRange("Journal Template Name", GenJournalBatch."Journal Template Name");

        GenJournalLine.SetRange("Journal Batch Name", GenJournalBatch.Name);

        if GenJournalLine.FindFirst() then
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);



        // Update payroll status 

        PayrollHeader.Status := PayrollHeader.Status::Posted;

        PayrollHeader.Modify();

    end;



    /// <summary> 

    /// Create individual journal line for payroll posting 

    /// </summary> 

    local procedure CreatePayrollJournalLine(var GenJournalLine: Record "Gen. Journal Line"; GenJournalBatch: Record "Gen. Journal Batch"; DocumentNo: Code[20]; var LineNo: Integer; PayHead: Record "HRMS Pay Head"; Employee: Record "HRMS Employee"; PayrollLine: Record "HRMS Payroll Line")

    begin

        GenJournalLine.Init();

        GenJournalLine."Journal Template Name" := GenJournalBatch."Journal Template Name";

        GenJournalLine."Journal Batch Name" := GenJournalBatch.Name;

        GenJournalLine."Line No." := LineNo;

        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";

        GenJournalLine."Account No." := PayHead."G/L Account No.";

        GenJournalLine."Posting Date" := WorkDate();

        GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice;

        GenJournalLine."Document No." := DocumentNo;

        GenJournalLine.Description := StrSubstNo('%1 - %2', Employee."Full Name", PayHead.Description);



        // Set amount based on pay head type 

        case PayHead."Pay Head Type" of

            PayHead."Pay Head Type"::Earning:

                GenJournalLine.Amount := -PayrollLine.Amount; // Credit 

            PayHead."Pay Head Type"::Deduction,

            PayHead."Pay Head Type"::"Employer Contribution":

                GenJournalLine.Amount := PayrollLine.Amount; // Debit 

        end;



        // Set dimensions 

        GenJournalLine."Shortcut Dimension 1 Code" := Employee."Department Code";

        GenJournalLine."Shortcut Dimension 2 Code" := Employee."Position Code";



        GenJournalLine.Insert();

    end;

}
