codeunit 81000 "HRMS Payroll Test"

{

    Subtype = Test;

    TestPermissions = Disabled;



    [Test]

    procedure TestBasicPayrollCalculation()

    var

        Employee: Record "HRMS Employee";

        PayrollHeader: Record "HRMS Payroll Header";

        PayrollLine: Record "HRMS Payroll Line";

        PayrollCalculation: Codeunit "HRMS Payroll Calculation";

        LibraryHRMS: Codeunit "Library - HRMS";

    begin

        // Setup 

        LibraryHRMS.CreateEmployee(Employee);

        LibraryHRMS.CreatePayrollPeriod(PayrollHeader);

        Employee."Basic Salary" := 50000;

        Employee.Modify();



        // Execute 

        PayrollCalculation.CalculatePayroll(PayrollHeader);



        // Verify 

        PayrollLine.SetRange("Payroll Period", PayrollHeader."Payroll Period");

        PayrollLine.SetRange("Employee No.", Employee."No.");

        //Assert.RecordIsNotEmpty(PayrollLine);

    end;



    [Test]

    procedure TestPFCalculation()

    var

        Employee: Record "HRMS Employee";

        PayrollHeader: Record "HRMS Payroll Header";

        PayrollLine: Record "HRMS Payroll Line";

        PayrollCalculation: Codeunit "HRMS Payroll Calculation";

        LibraryHRMS: Codeunit "Library - HRMS";

        ExpectedPFAmount: Decimal;

    begin

        // Setup 

        LibraryHRMS.CreateEmployee(Employee);

        LibraryHRMS.CreatePayrollPeriod(PayrollHeader);

        Employee."Basic Salary" := 15000;

        Employee."PF No." := 'PF123456';

        Employee.Modify();



        ExpectedPFAmount := 1800; // Max PF amount 



        // Execute 

        PayrollCalculation.CalculatePayroll(PayrollHeader);



        // Verify 

        PayrollLine.SetRange("Payroll Period", PayrollHeader."Payroll Period");

        PayrollLine.SetRange("Employee No.", Employee."No.");

        PayrollLine.SetRange("Pay Head Code", 'PF-EE');

        PayrollLine.FindFirst();

        // Assert.AreEqual(ExpectedPFAmount, PayrollLine.Amount, 'PF calculation incorrect');

    end;



    [Test]

    procedure TestESICalculation()

    var

        Employee: Record "HRMS Employee";

        PayrollHeader: Record "HRMS Payroll Header";

        PayrollLine: Record "HRMS Payroll Line";

        PayrollCalculation: Codeunit "HRMS Payroll Calculation";

        LibraryHRMS: Codeunit "Library - HRMS";

        ExpectedESIAmount: Decimal;

    begin

        // Setup 

        LibraryHRMS.CreateEmployee(Employee);

        LibraryHRMS.CreatePayrollPeriod(PayrollHeader);

        Employee."Basic Salary" := 20000;

        Employee."ESI No." := 'ESI123456';

        Employee.Modify();



        ExpectedESIAmount := 150; // 0.75% of 20000 



        // Execute 

        PayrollCalculation.CalculatePayroll(PayrollHeader);



        // Verify 

        PayrollLine.SetRange("Payroll Period", PayrollHeader."Payroll Period");

        PayrollLine.SetRange("Employee No.", Employee."No.");

        PayrollLine.SetRange("Pay Head Code", 'ESI-EE');

        PayrollLine.FindFirst();

        //Assert.AreEqual(ExpectedESIAmount, PayrollLine.Amount, 'ESI calculation incorrect');

    end;

}