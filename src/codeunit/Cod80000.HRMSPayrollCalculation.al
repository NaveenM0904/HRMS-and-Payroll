codeunit 80011 "HRMS Payroll Calculation"

{

    /// <summary> 

    /// Main payroll calculation procedure 

    /// </summary> 

    /// <param name="PayrollHeader">Payroll Header Record</param> 

    procedure CalculatePayroll(var PayrollHeader: Record "HRMS Payroll Header")

    var

        Employee: Record "HRMS Employee";

        PayrollLine: Record "HRMS Payroll Line";

        SalaryStructure: Record "HRMS Salary Structure";

    // SalaryStructureLine: Record "HRMS Salary Structure Line";

    // AttendanceData: Record "HRMS Attendance";

    // PayrollCalculationMgt: Codeunit "HRMS Payroll Calc Management";

    begin

        // Validate payroll header 

        PayrollHeader.TestField("Period Start Date");

        PayrollHeader.TestField("Period End Date");



        // Clear existing payroll lines 

        PayrollLine.SetRange("Payroll Period", PayrollHeader."Payroll Period");

        PayrollLine.DeleteAll();



        // Process each active employee 

        Employee.SetRange(Status, Employee.Status::Active);

        Employee.SetFilter("Employment Date", '<=%1', PayrollHeader."Period End Date");



        if Employee.FindSet() then
            repeat

                CalculateEmployeePayroll(PayrollHeader, Employee);

            until Employee.Next() = 0;



        // Update payroll summary 

        //UpdatePayrollSummary(PayrollHeader);



        // Update status 

        PayrollHeader.Status := PayrollHeader.Status::"In Progress";

        PayrollHeader."Processed Date" := Today;

        PayrollHeader."Processed By" := UserId;

        PayrollHeader.Modify();

    end;



    /// <summary> 

    /// Calculate payroll for individual employee 

    /// </summary> 

    local procedure CalculateEmployeePayroll(PayrollHeader: Record "HRMS Payroll Header"; Employee: Record "HRMS Employee")

    var

        SalaryStructure: Record "HRMS Salary Structure";

        //SalaryStructureLine: Record "HRMS Salary Structure Line";

        PayrollLine: Record "HRMS Payroll Line";

        AttendanceDays: Decimal;

        WorkingDays: Decimal;

        BasicSalary: Decimal;

        GrossSalary: Decimal;

    begin

        // Get employee salary structure 

        if Employee."Salary Structure Code" = '' then
            exit;



        SalaryStructure.Get(Employee."Salary Structure Code");



        // Calculate attendance factor 

        // AttendanceDays := GetEmployeeAttendance(Employee."No.", PayrollHeader."Period Start Date", PayrollHeader."Period End Date");

        // WorkingDays := GetWorkingDays(PayrollHeader."Period Start Date", PayrollHeader."Period End Date");



        // Process salary structure lines 

        // SalaryStructureLine.SetRange("Salary Structure Code", Employee."Salary Structure Code");

        // if SalaryStructureLine.FindSet() then
        //     repeat

        //         CreatePayrollLine(PayrollHeader, Employee, SalaryStructureLine, AttendanceDays, WorkingDays);

        //     until SalaryStructureLine.Next() = 0;



        // Calculate statutory deductions 

        // CalculateStatutoryDeductions(PayrollHeader, Employee);

    end;



    /// <summary> 

    /// Create payroll line for specific pay head 

    /// </summary> 

    local procedure CreatePayrollLine(PayrollHeader: Record "HRMS Payroll Header"; Employee: Record "HRMS Employee"; /*SalaryStructureLine: Record "HRMS Salary Structure Line";*/ AttendanceDays: Decimal; WorkingDays: Decimal)

    var

        PayrollLine: Record "HRMS Payroll Line";

        PayHead: Record "HRMS Pay Head";

        CalculatedAmount: Decimal;

    begin

        //PayHead.Get(SalaryStructureLine."Pay Head Code");



        // Calculate amount based on calculation type 

        // case SalaryStructureLine."Calculation Type" of

        //     SalaryStructureLine."Calculation Type"::"Fixed Amount":

        //         CalculatedAmount := SalaryStructureLine.Amount;

        //     SalaryStructureLine."Calculation Type"::"Percentage of Basic":

        //         CalculatedAmount := (Employee."Basic Salary" * SalaryStructureLine.Percentage) / 100;

        //     SalaryStructureLine."Calculation Type"::"Percentage of Gross":

        begin

            // Calculate gross amount first 

            // CalculatedAmount := (GetGrossAmount(PayrollHeader, Employee) * SalaryStructureLine.Percentage) / 100;

        end;

    end;



    // Apply attendance factor for earnings 

    // if PayHead."Pay Head Type" = PayHead."Pay Head Type"::Earning then
    //     CalculatedAmount := (CalculatedAmount * AttendanceDays) / WorkingDays;



    // Create payroll line 

    // PayrollLine.Init();

    //     PayrollLine."Payroll Period" := PayrollHeader."Payroll Period";

    //     PayrollLine."Employee No." := Employee."No.";

    //     PayrollLine."Pay Head Code" := SalaryStructureLine."Pay Head Code";

    //     PayrollLine."Pay Head Type" := PayHead."Pay Head Type";

    //     PayrollLine.Amount := Round(CalculatedAmount, 0.01);

    //     PayrollLine.Insert();

    // end;



    /// <summary> 

    /// Calculate statutory deductions (PF, ESI, TDS) 

    /// </summary> 

    local procedure CalculateStatutoryDeductions(PayrollHeader: Record "HRMS Payroll Header"; Employee: Record "HRMS Employee")

    var

        PayrollLine: Record "HRMS Payroll Line";

        PFAmount: Decimal;

        ESIAmount: Decimal;

        TDSAmount: Decimal;

        GrossAmount: Decimal;

        TaxableAmount: Decimal;

    begin

        // GrossAmount := GetGrossAmount(PayrollHeader, Employee);

        // TaxableAmount := GetTaxableAmount(PayrollHeader, Employee);



        // Calculate PF (12% of Basic + DA, max 1800) 

        if Employee."PF No." <> '' then begin

            PFAmount := (Employee."Basic Salary" * 12) / 100;

            if PFAmount > 1800 then
                PFAmount := 1800;



            CreateStatutoryPayrollLine(PayrollHeader, Employee, 'PF-EE', PFAmount);

            CreateStatutoryPayrollLine(PayrollHeader, Employee, 'PF-ER', PFAmount); // Employer contribution 

        end;



        // Calculate ESI (0.75% of Gross, applicable up to 21000) 

        if (Employee."ESI No." <> '') and (GrossAmount <= 21000) then begin

            ESIAmount := (GrossAmount * 0.75) / 100;

            CreateStatutoryPayrollLine(PayrollHeader, Employee, 'ESI-EE', ESIAmount);



            // Employer ESI (3.25%) 

            CreateStatutoryPayrollLine(PayrollHeader, Employee, 'ESI-ER', (GrossAmount * 3.25) / 100);

        end;



        // Calculate TDS based on tax slabs 

        TDSAmount := CalculateTDS(Employee, TaxableAmount);

        if TDSAmount > 0 then
            CreateStatutoryPayrollLine(PayrollHeader, Employee, 'TDS', TDSAmount);

    end;



    /// <summary> 

    /// Create statutory payroll line 

    /// </summary> 

    local procedure CreateStatutoryPayrollLine(PayrollHeader: Record "HRMS Payroll Header"; Employee: Record "HRMS Employee"; PayHeadCode: Code[20]; Amount: Decimal)

    var

        PayrollLine: Record "HRMS Payroll Line";

        PayHead: Record "HRMS Pay Head";

    begin

        if Amount = 0 then
            exit;



        PayHead.Get(PayHeadCode);



        PayrollLine.Init();

        PayrollLine."Payroll Period" := PayrollHeader."Payroll Period";

        PayrollLine."Employee No." := Employee."No.";

        PayrollLine."Pay Head Code" := PayHeadCode;

        PayrollLine."Pay Head Type" := PayHead."Pay Head Type";

        PayrollLine.Amount := Round(Amount, 0.01);

        PayrollLine.Insert();

    end;



    /// <summary> 

    /// Get employee attendance for the period 

    /// </summary> 

    local procedure GetEmployeeAttendance(EmployeeNo: Code[20]; StartDate: Date; EndDate: Date): Decimal

    var

        // AttendanceData: Record "HRMS Attendance";

        TotalDays: Decimal;

    begin

        // AttendanceData.SetRange("Employee No.", EmployeeNo);

        // AttendanceData.SetRange("Attendance Date", StartDate, EndDate);

        // AttendanceData.SetRange("Attendance Status", AttendanceData."Attendance Status"::Present);



        // if AttendanceData.FindSet() then
        //     TotalDays := AttendanceData.Count();



        exit(TotalDays);

    end;



    /// <summary> 

    /// Get working days in the period 

    /// </summary> 

    local procedure GetWorkingDays(StartDate: Date; EndDate: Date): Decimal

    var

        Calendar: Record Date;

        WorkingDays: Decimal;

    begin

        Calendar.SetRange("Period Start", StartDate, EndDate);

        Calendar.SetFilter("Period Type", '%1|%2', Calendar."Period Type"::Date, Calendar."Period Type"::Date);



        if Calendar.FindSet() then
            repeat

            // if Calendar."Period Start" in [Monday .. Friday] then
            //     WorkingDays += 1;

            until Calendar.Next() = 0;



        exit(WorkingDays);

    end;



    /// <summary> 

    /// Calculate TDS based on income tax slabs 

    /// </summary> 

    local procedure CalculateTDS(Employee: Record "HRMS Employee"; TaxableAmount: Decimal): Decimal

    var

        TDSAmount: Decimal;

        AnnualTaxableAmount: Decimal;

        MonthlyTDS: Decimal;

    begin

        AnnualTaxableAmount := TaxableAmount * 12;



        // Apply standard deduction of 50,000 

        AnnualTaxableAmount -= 50000;



        // Calculate tax as per income tax slabs (FY 2024-25) 

        if AnnualTaxableAmount > 250000 then begin

            if AnnualTaxableAmount <= 500000 then
                TDSAmount := (AnnualTaxableAmount - 250000) * 0.05

            else if AnnualTaxableAmount <= 1000000 then
                TDSAmount := 12500 + ((AnnualTaxableAmount - 500000) * 0.20)

            else
                TDSAmount := 112500 + ((AnnualTaxableAmount - 1000000) * 0.30);



            MonthlyTDS := TDSAmount / 12;

        end;



        exit(Round(MonthlyTDS, 0.01));

    end;

}