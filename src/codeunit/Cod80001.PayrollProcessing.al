
codeunit 80001 "Payroll Processing"
{
    procedure ProcessMonthlyPayroll(PayrollMonth: Integer; PayrollYear: Integer)
    var
        Employee: Record "HRMS Employee";
        PayrollEntry: Record "HRMS Payroll Entry";
        HRMSSetup: Record "HRMS Setup";
        BatchNo: Code[20];
        NoSeriesMgt: Codeunit "No. Series";
    begin
        HRMSSetup.Get();
        HRMSSetup.TestField("Payroll Batch Nos.");

        // Generate batch number
        BatchNo := NoSeriesMgt.GetNextNo(HRMSSetup."Payroll Batch Nos.", Today, true);

        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindSet() then begin
            repeat
                ProcessEmployeePayroll(Employee, PayrollMonth, PayrollYear, BatchNo);
            until Employee.Next() = 0;
        end;

        Message('Payroll processed successfully for batch %1.', BatchNo);
    end;

    local procedure ProcessEmployeePayroll(Employee: Record "HRMS Employee"; PayrollMonth: Integer; PayrollYear: Integer; BatchNo: Code[20])
    var
        PayrollEntry: Record "HRMS Payroll Entry";
        SalaryStructure: Record "HRMS Salary Structure";
        HRMSSetup: Record "HRMS Setup";
        HRMSManagement: Codeunit "HRMS Management";
        BasicSalary: Decimal;
        GrossSalary: Decimal;
        DaysWorked: Decimal;
        DaysInMonth: Integer;
    begin
        // Check if payroll already processed for this month
        PayrollEntry.SetRange("Employee No.", Employee."No.");
        PayrollEntry.SetRange("Payroll Month", PayrollMonth);
        PayrollEntry.SetRange("Payroll Year", PayrollYear);
        if not PayrollEntry.IsEmpty then
            exit; // Already processed

        HRMSSetup.Get();
        BasicSalary := Employee."Basic Salary";

        // Calculate days in month and days worked
        DaysInMonth := Date2DMY(CalcDate('<CM>', DMY2Date(1, PayrollMonth, PayrollYear)), 1);
        DaysWorked := CalculateDaysWorked(Employee."No.", PayrollMonth, PayrollYear);

        // Prorate salary based on days worked
        if DaysWorked <> DaysInMonth then
            BasicSalary := BasicSalary * DaysWorked / DaysInMonth;

        GrossSalary := HRMSManagement.CalculateGrossSalary(Employee."No.", BasicSalary);

        // Create payroll entry
        PayrollEntry.Init();
        PayrollEntry."Payroll Batch No." := BatchNo;
        PayrollEntry."Employee No." := Employee."No.";
        PayrollEntry."Employee Name" := Employee."Full Name";
        PayrollEntry."Payroll Month" := PayrollMonth;
        PayrollEntry."Payroll Year" := PayrollYear;
        PayrollEntry."Days Worked" := DaysWorked;
        PayrollEntry."Days in Month" := DaysInMonth;
        PayrollEntry."Basic Salary" := BasicSalary;

        // Calculate allowances
        if SalaryStructure.Get(Employee."Salary Structure Code") then begin
            if SalaryStructure."HRA %" > 0 then
                PayrollEntry."HRA" := BasicSalary * SalaryStructure."HRA %" / 100;
            PayrollEntry."Medical Allowance" := SalaryStructure."Medical Allowance";
            PayrollEntry."Transport Allowance" := SalaryStructure."Transport Allowance";
            if SalaryStructure."Special Allowance %" > 0 then
                PayrollEntry."Special Allowance" := BasicSalary * SalaryStructure."Special Allowance %" / 100;
        end;

        PayrollEntry."Gross Salary" := PayrollEntry."Basic Salary" + PayrollEntry."HRA" +
            PayrollEntry."Medical Allowance" + PayrollEntry."Transport Allowance" + PayrollEntry."Special Allowance";

        // Calculate deductions
        CalculateDeductions(PayrollEntry, Employee, SalaryStructure);

        // Calculate net salary
        PayrollEntry."Net Salary" := PayrollEntry."Gross Salary" - PayrollEntry."Total Deductions";

        PayrollEntry.Insert();
    end;

    /// <summary>
    /// Calculate deductions for payroll entry
    /// </summary>
    /// <param name="PayrollEntry">Payroll entry record (var)</param>
    /// <param name="Employee">Employee record</param>
    /// <param name="SalaryStructure">Salary structure record</param>
    local procedure CalculateDeductions(var PayrollEntry: Record "HRMS Payroll Entry"; Employee: Record "HRMS Employee"; SalaryStructure: Record "HRMS Salary Structure")
    var
        HRMSSetup: Record "HRMS Setup";
    begin
        HRMSSetup.Get();

        // PF Deduction
        if SalaryStructure."PF Applicable" and (HRMSSetup."PF Rate %" > 0) then
            PayrollEntry."PF Deduction" := PayrollEntry."Basic Salary" * HRMSSetup."PF Rate %" / 100;

        // ESI Deduction
        if SalaryStructure."ESI Applicable" and (HRMSSetup."ESI Rate %" > 0) then
            PayrollEntry."ESI Deduction" := PayrollEntry."Gross Salary" * HRMSSetup."ESI Rate %" / 100;

        // Professional Tax
        if SalaryStructure."Professional Tax Applicable" then
            PayrollEntry."Professional Tax" := HRMSSetup."Professional Tax";

        // Calculate total deductions
        PayrollEntry."Total Deductions" := PayrollEntry."PF Deduction" + PayrollEntry."ESI Deduction" +
            PayrollEntry."Professional Tax" + PayrollEntry."TDS" + PayrollEntry."Other Deductions";
    end;

    /// <summary>
    /// Calculate days worked for an employee in a month
    /// </summary>
    /// <param name="EmployeeNo">Employee number</param>
    /// <param name="PayrollMonth">Payroll month</param>
    /// <param name="PayrollYear">Payroll year</param>
    /// <returns>Number of days worked</returns>
    local procedure CalculateDaysWorked(EmployeeNo: Code[20]; PayrollMonth: Integer; PayrollYear: Integer): Decimal
    var
        LeaveApplication: Record "HRMS Leave Application";
        Employee: Record "HRMS Employee";
        FromDate: Date;
        ToDate: Date;
        DaysInMonth: Integer;
        LeaveDays: Decimal;
    begin
        FromDate := DMY2Date(1, PayrollMonth, PayrollYear);
        ToDate := CalcDate('<CM>', FromDate);
        DaysInMonth := Date2DMY(ToDate, 1);

        // Check employment date
        if Employee.Get(EmployeeNo) then begin
            if Employee."Employment Date" > ToDate then
                exit(0);
            if Employee."Employment Date" > FromDate then begin
                DaysInMonth := ToDate - Employee."Employment Date" + 1;
                FromDate := Employee."Employment Date";
            end;
        end;

        // Calculate leave days in the month
        LeaveApplication.SetRange("Employee No.", EmployeeNo);
        LeaveApplication.SetRange(Status, LeaveApplication.Status::Approved);
        LeaveApplication.SetFilter("From Date", '..%1', ToDate);
        LeaveApplication.SetFilter("To Date", '%1..', FromDate);

        if LeaveApplication.FindSet() then begin
            repeat
                LeaveDays += CalculateOverlapDays(LeaveApplication."From Date", LeaveApplication."To Date", FromDate, ToDate);
            until LeaveApplication.Next() = 0;
        end;

        exit(DaysInMonth - LeaveDays);
    end;

    /// <summary>
    /// Calculate overlapping days between two date ranges
    /// </summary>
    /// <param name="LeaveFromDate">Leave from date</param>
    /// <param name="LeaveToDate">Leave to date</param>
    /// <param name="MonthFromDate">Month from date</param>
    /// <param name="MonthToDate">Month to date</param>
    /// <returns>Number of overlapping days</returns>
    local procedure CalculateOverlapDays(LeaveFromDate: Date; LeaveToDate: Date; MonthFromDate: Date; MonthToDate: Date): Decimal
    var
        OverlapStart: Date;
        OverlapEnd: Date;
    begin
        OverlapStart := MaxDate(LeaveFromDate, MonthFromDate);
        OverlapEnd := MinDate(LeaveToDate, MonthToDate);

        if OverlapStart <= OverlapEnd then
            exit(OverlapEnd - OverlapStart + 1)
        else
            exit(0);
    end;

    /// <summary>
    /// Get maximum of two dates
    /// </summary>
    /// <param name="Date1">First date</param>
    /// <param name="Date2">Second date</param>
    /// <returns>Maximum date</returns>
    local procedure MaxDate(Date1: Date; Date2: Date): Date
    begin
        if Date1 > Date2 then
            exit(Date1)
        else
            exit(Date2);
    end;

    /// <summary>
    /// Get minimum of two dates
    /// </summary>
    /// <param name="Date1">First date</param>
    /// <param name="Date2">Second date</param>
    /// <returns>Minimum date</returns>
    local procedure MinDate(Date1: Date; Date2: Date): Date
    begin
        if Date1 < Date2 then
            exit(Date1)
        else
            exit(Date2);
    end;

    /// <summary>
    /// Generate payslips for processed payroll
    /// </summary>
    /// <param name="BatchNo">Payroll batch number</param>
    procedure GeneratePayslips(BatchNo: Code[20])
    var
        PayrollEntry: Record "HRMS Payroll Entry";
    begin
        PayrollEntry.SetRange("Payroll Batch No.", BatchNo);
        PayrollEntry.SetRange(Processed, true);

        if PayrollEntry.IsEmpty then begin
            Error('No processed payroll entries found for batch %1.', BatchNo);
            exit;
        end;

        Report.Run(Report::"Payroll Report", true, false, PayrollEntry);
    end;

    /// <summary>
    /// Mark payroll as processed
    /// </summary>
    /// <param name="BatchNo">Payroll batch number</param>
    procedure MarkPayrollProcessed(BatchNo: Code[20])
    var
        PayrollEntry: Record "HRMS Payroll Entry";
    begin
        PayrollEntry.SetRange("Payroll Batch No.", BatchNo);
        PayrollEntry.ModifyAll(Processed, true);
        PayrollEntry.ModifyAll("Processing Date", Today);
    end;
}
