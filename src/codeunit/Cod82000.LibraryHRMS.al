codeunit 82000 "Library - HRMS"

{

    procedure CreateEmployee(var Employee: Record "HRMS Employee")

    var

    // LibraryUtility: Codeunit "Library - Utility";

    begin

        Employee.Init();

        //Employee."No." := LibraryUtility.GenerateRandomCode(Employee.FieldNo("No."), DATABASE::"HRMS Employee");

        Employee."First Name" := 'Test';

        Employee."Last Name" := 'Employee';

        Employee."Full Name" := Employee."First Name" + ' ' + Employee."Last Name";

        Employee."Employment Date" := WorkDate();

        Employee.Status := Employee.Status::Active;

        Employee."Department Code" := CreateDepartment();

        Employee."Position Code" := CreatePosition();

        Employee."Basic Salary" := 50000;

        Employee.Insert(true);

    end;



    procedure CreateDepartment(): Code[20]

    var

        Department: Record "HRMS Department";

    //  LibraryUtility: Codeunit "Library - Utility";

    begin

        Department.Init();

        //Department.Code := LibraryUtility.GenerateRandomCode(Department.FieldNo(Code), DATABASE::"HRMS Department");

        Department.Name := 'Test Department';

        Department.Insert();

        exit(Department.Code);

    end;



    procedure CreatePosition(): Code[20]

    var

        Position: Record "HRMS Position";

    // LibraryUtility: Codeunit "Library - Utility";

    begin

        Position.Init();

        // Position.Code := LibraryUtility.GenerateRandomCode(Position.FieldNo(Code), DATABASE::"HRMS Position");

        // Position.Title := 'Test Position';

        Position.Insert();

        // exit(Position.Code);

    end;



    procedure CreatePayrollPeriod(var PayrollHeader: Record "HRMS Payroll Header")

    begin

        PayrollHeader.Init();

        PayrollHeader."Payroll Period" := Format(Date2DMY(WorkDate(), 2)) + '-' + Format(Date2DMY(WorkDate(), 3));

        PayrollHeader."Period Start Date" := CalcDate('<-CM>', WorkDate());

        PayrollHeader."Period End Date" := CalcDate('<CM>', WorkDate());

        PayrollHeader.Status := PayrollHeader.Status::Open;

        PayrollHeader.Insert();

    end;

}
