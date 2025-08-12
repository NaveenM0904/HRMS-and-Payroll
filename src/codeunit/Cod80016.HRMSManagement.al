
codeunit 80016 "HRMS Management"
{
    procedure CalculateLeaveBalance(EmployeeNo: Code[20]): Decimal
    var
        Employee: Record "HRMS Employee";
        LeaveApplication: Record "HRMS Leave Application";
        HRMSSetup: Record "HRMS Setup";
        TotalLeaveEntitled: Decimal;
        TotalLeaveTaken: Decimal;
    begin
        if not Employee.Get(EmployeeNo) then
            exit(0);

        HRMSSetup.Get();
        TotalLeaveEntitled := HRMSSetup."Default Leave Days";

        // Calculate total approved leave taken in current year
        LeaveApplication.SetRange("Employee No.", EmployeeNo);
        LeaveApplication.SetRange(Status, LeaveApplication.Status::Approved);
        LeaveApplication.SetFilter("From Date", '%1..%2', DMY2Date(1, 1, Date2DMY(Today, 3)), DMY2Date(31, 12, Date2DMY(Today, 3)));

        if LeaveApplication.FindSet() then begin
            repeat
                TotalLeaveTaken += LeaveApplication."No. of Days";
            until LeaveApplication.Next() = 0;
        end;

        exit(TotalLeaveEntitled - TotalLeaveTaken);
    end;

    /// <summary>
    /// Update employee leave balance
    /// </summary>
    /// <param name="EmployeeNo">Employee number</param>
    procedure UpdateEmployeeLeaveBalance(EmployeeNo: Code[20])
    var
        Employee: Record "HRMS Employee";
        LeaveBalance: Decimal;
    begin
        if Employee.Get(EmployeeNo) then begin
            LeaveBalance := CalculateLeaveBalance(EmployeeNo);
            Employee."Leave Balance" := LeaveBalance;
            Employee.Modify();
        end;
    end;

    /// <summary>
    /// Validate leave application
    /// </summary>
    /// <param name="LeaveApplication">Leave application record</param>
    /// <returns>True if valid, false otherwise</returns>
    procedure ValidateLeaveApplication(var LeaveApplication: Record "HRMS Leave Application"): Boolean
    var
        Employee: Record "HRMS Employee";
        LeaveType: Record "HRMS Leave Type";
        OverlapLeave: Record "HRMS Leave Application";
        LeaveBalance: Decimal;
    begin
        // Check if employee exists and is active
        if not Employee.Get(LeaveApplication."Employee No.") then begin
            Error('Employee %1 does not exist.', LeaveApplication."Employee No.");
            exit(false);
        end;

        if Employee.Status <> Employee.Status::Active then begin
            Error('Employee %1 is not active.', LeaveApplication."Employee No.");
            exit(false);
        end;

        // Check if leave type exists and is active
        if not LeaveType.Get(LeaveApplication."Leave Type Code") then begin
            Error('Leave Type %1 does not exist.', LeaveApplication."Leave Type Code");
            exit(false);
        end;

        if not LeaveType.Active then begin
            Error('Leave Type %1 is not active.', LeaveApplication."Leave Type Code");
            exit(false);
        end;

        // Check for overlapping leave applications
        OverlapLeave.SetRange("Employee No.", LeaveApplication."Employee No.");
        OverlapLeave.SetFilter("Application No.", '<>%1', LeaveApplication."Application No.");
        OverlapLeave.SetRange(Status, OverlapLeave.Status::Approved);
        OverlapLeave.SetFilter("From Date", '..%1', LeaveApplication."To Date");
        OverlapLeave.SetFilter("To Date", '%1..', LeaveApplication."From Date");

        if not OverlapLeave.IsEmpty then begin
            Error('Leave application overlaps with existing approved leave.');
            exit(false);
        end;

        // Check leave balance
        LeaveBalance := CalculateLeaveBalance(LeaveApplication."Employee No.");
        if LeaveApplication."No. of Days" > LeaveBalance then begin
            Error('Insufficient leave balance. Available: %1 days, Requested: %2 days.', LeaveBalance, LeaveApplication."No. of Days");
            exit(false);
        end;

        exit(true);
    end;

    /// <summary>
    /// Calculate gross salary based on salary structure
    /// </summary>
    /// <param name="EmployeeNo">Employee number</param>
    /// <param name="BasicSalary">Basic salary amount</param>
    /// <returns>Gross salary amount</returns>
    procedure CalculateGrossSalary(EmployeeNo: Code[20]; BasicSalary: Decimal): Decimal
    var
        Employee: Record "HRMS Employee";
        SalaryStructure: Record "HRMS Salary Structure";
        GrossSalary: Decimal;
    begin
        if not Employee.Get(EmployeeNo) then
            exit(0);

        if not SalaryStructure.Get(Employee."Salary Structure Code") then
            exit(BasicSalary);

        GrossSalary := BasicSalary;

        // Add HRA
        if SalaryStructure."HRA %" > 0 then
            GrossSalary += BasicSalary * SalaryStructure."HRA %" / 100;

        // Add Medical Allowance
        GrossSalary += SalaryStructure."Medical Allowance";

        // Add Transport Allowance
        GrossSalary += SalaryStructure."Transport Allowance";

        // Add Special Allowance
        if SalaryStructure."Special Allowance %" > 0 then
            GrossSalary += BasicSalary * SalaryStructure."Special Allowance %" / 100;

        exit(GrossSalary);
    end;

    /// <summary>
    /// Get employees by department
    /// </summary>
    /// <param name="DepartmentCode">Department code</param>
    /// <param name="Employee">Employee record (var)</param>
    procedure GetEmployeesByDepartment(DepartmentCode: Code[20]; var Employee: Record "HRMS Employee")
    begin
        Employee.SetRange("Department Code", DepartmentCode);
        Employee.SetRange(Status, Employee.Status::Active);
    end;

    /// <summary>
    /// Get employees by position
    /// </summary>
    /// <param name="PositionCode">Position code</param>
    /// <param name="Employee">Employee record (var)</param>
    procedure GetEmployeesByPosition(PositionCode: Code[20]; var Employee: Record "HRMS Employee")
    begin
        Employee.SetRange("Position Code", PositionCode);
        Employee.SetRange(Status, Employee.Status::Active);
    end;

    /// <summary>
    /// Send leave application notification
    /// </summary>
    /// <param name="LeaveApplication">Leave application record</param>
    procedure SendLeaveNotification(LeaveApplication: Record "HRMS Leave Application")
    var
        Employee: Record "HRMS Employee";
        Manager: Record "HRMS Employee";
        NotificationText: Text;
    begin
        if not Employee.Get(LeaveApplication."Employee No.") then
            exit;

        case LeaveApplication.Status of
            LeaveApplication.Status::Pending:
                begin
                    if Manager.Get(Employee."Manager Employee No.") then begin
                        NotificationText := StrSubstNo('Leave application %1 submitted by %2 for %3 days from %4 to %5.',
                            LeaveApplication."Application No.",
                            Employee."Full Name",
                            LeaveApplication."No. of Days",
                            LeaveApplication."From Date",
                            LeaveApplication."To Date");
                        // Send notification to manager
                    end;
                end;
            LeaveApplication.Status::Approved:
                begin
                    NotificationText := StrSubstNo('Your leave application %1 has been approved.',
                        LeaveApplication."Application No.");
                    // Send notification to employee
                end;
            LeaveApplication.Status::Rejected:
                begin
                    NotificationText := StrSubstNo('Your leave application %1 has been rejected. Reason: %2',
                        LeaveApplication."Application No.",
                        LeaveApplication."Rejection Reason");
                    // Send notification to employee
                end;
        end;
    end;
}
