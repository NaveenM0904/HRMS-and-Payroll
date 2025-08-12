/// <summary>
/// Report Payroll Report (ID 70001)
/// Payroll and payslip report
/// </summary>
report 70001 "Payroll Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/PayrollReport.rdlc';
    Caption = 'Payroll Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(PayrollEntry; "HRMS Payroll Entry")
        {
            RequestFilterFields = "Payroll Batch No.", "Employee No.", "Payroll Month", "Payroll Year";

            column(CompanyName; CompanyProperty.DisplayName())
            {
            }

            column(ReportTitle; ReportTitle)
            {
            }

            column(FilterString; FilterString)
            {
            }

            column(PrintDate; Format(Today, 0, 4))
            {
            }

            column(PrintTime; Format(Time, 0, 1))
            {
            }

            column(PayrollMonth_Year; PayrollMonthYear)
            {
            }

            column(PayrollEntry_EntryNo; "Entry No.")
            {
            }

            column(PayrollEntry_PayrollBatchNo; "Payroll Batch No.")
            {
            }

            column(PayrollEntry_EmployeeNo; "Employee No.")
            {
            }

            column(PayrollEntry_EmployeeName; "Employee Name")
            {
            }

            column(PayrollEntry_PayrollMonth; "Payroll Month")
            {
            }

            column(PayrollEntry_PayrollYear; "Payroll Year")
            {
            }

            column(PayrollEntry_BasicSalary; "Basic Salary")
            {
            }

            column(PayrollEntry_HRA; HRA)
            {
            }

            column(PayrollEntry_MedicalAllowance; "Medical Allowance")
            {
            }

            column(PayrollEntry_TransportAllowance; "Transport Allowance")
            {
            }

            column(PayrollEntry_SpecialAllowance; "Special Allowance")
            {
            }

            column(PayrollEntry_GrossSalary; "Gross Salary")
            {
            }

            column(PayrollEntry_PFDeduction; "PF Deduction")
            {
            }

            column(PayrollEntry_ESIDeduction; "ESI Deduction")
            {
            }

            column(PayrollEntry_ProfessionalTax; "Professional Tax")
            {
            }

            column(PayrollEntry_TDS; TDS)
            {
            }

            column(PayrollEntry_OtherDeductions; "Other Deductions")
            {
            }

            column(PayrollEntry_TotalDeductions; "Total Deductions")
            {
            }

            column(PayrollEntry_NetSalary; "Net Salary")
            {
            }

            column(PayrollEntry_DaysWorked; "Days Worked")
            {
            }

            column(PayrollEntry_DaysInMonth; "Days in Month")
            {
            }

            column(PayrollEntry_LeaveDays; "Leave Days")
            {
            }

            column(PayrollEntry_Processed; Processed)
            {
            }

            column(PayrollEntry_ProcessingDate; Format("Processing Date", 0, 4))
            {
            }

            // Employee additional information
            column(Employee_DepartmentCode; Employee."Department Code")
            {
            }

            column(Employee_DepartmentName; Employee."Department Name")
            {
            }

            column(Employee_PositionCode; Employee."Position Code")
            {
            }

            column(Employee_PositionTitle; Employee."Position Title")
            {
            }

            column(Employee_PANNo; Employee."PAN No.")
            {
            }

            column(Employee_PFNo; Employee."PF No.")
            {
            }

            column(Employee_ESINo; Employee."ESI No.")
            {
            }

            column(Employee_UANNo; Employee."UAN No.")
            {
            }

            column(Employee_BankAccountNo; Employee."Bank Account No.")
            {
            }

            column(Employee_BankName; Employee."Bank Name")
            {
            }

            column(Employee_IFSCCode; Employee."IFSC Code")
            {
            }

            // Summary totals
            column(TotalBasicSalary; TotalBasicSalary)
            {
            }

            column(TotalGrossSalary; TotalGrossSalary)
            {
            }

            column(TotalDeductions; TotalDeductions)
            {
            }

            column(TotalNetSalary; TotalNetSalary)
            {
            }

            column(EmployeeCount; EmployeeCount)
            {
            }

            trigger OnPreDataItem()
            begin
                FilterString := PayrollEntry.GetFilters;

                // Set report title based on report type
                case ReportType of
                    ReportType::"Payroll Summary":
                        ReportTitle := 'Payroll Summary Report';
                    ReportType::Payslip:
                        ReportTitle := 'Employee Payslip';
                    ReportType::"Detailed Payroll":
                        ReportTitle := 'Detailed Payroll Report';
                end;

                // Initialize totals
                TotalBasicSalary := 0;
                TotalGrossSalary := 0;
                TotalDeductions := 0;
                TotalNetSalary := 0;
                EmployeeCount := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                // Get employee information
                if Employee.Get("Employee No.") then;

                // Set payroll month/year display
                PayrollMonthYear := Format("Payroll Month") + '/' + Format("Payroll Year");

                // Update totals
                TotalBasicSalary += "Basic Salary";
                TotalGrossSalary += "Gross Salary";
                TotalDeductions += "Total Deductions";
                TotalNetSalary += "Net Salary";
                EmployeeCount += 1;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(ReportType; ReportType)
                    {
                        ApplicationArea = All;
                        Caption = 'Report Type';
                        ToolTip = 'Select the type of payroll report to generate';
                        OptionCaption = 'Payroll Summary,Payslip,Detailed Payroll';

                        trigger OnValidate()
                        begin
                            UpdateReportOptions();
                        end;
                    }

                    field(IncludeEmployeeDetails; IncludeEmployeeDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Employee Details';
                        ToolTip = 'Include detailed employee information like department, position';
                        Enabled = ReportType <> ReportType::Payslip;
                    }

                    field(IncludeStatutoryInfo; IncludeStatutoryInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Statutory Information';
                        ToolTip = 'Include statutory numbers like PAN, PF, ESI';
                    }

                    field(IncludeBankDetails; IncludeBankDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Bank Details';
                        ToolTip = 'Include bank account information';
                        Enabled = ReportType = ReportType::Payslip;
                    }

                    field(ShowSummaryTotals; ShowSummaryTotals)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Summary Totals';
                        ToolTip = 'Show summary totals at the end of the report';
                        Enabled = ReportType <> ReportType::Payslip;
                    }

                    field(OneEmployeePerPage; OneEmployeePerPage)
                    {
                        ApplicationArea = All;
                        Caption = 'One Employee Per Page';
                        ToolTip = 'Print each employee on a separate page';
                        Enabled = ReportType = ReportType::Payslip;
                    }
                }

                group(Grouping)
                {
                    Caption = 'Grouping';
                    Enabled = ReportType <> ReportType::Payslip;

                    field(GroupByDepartment; GroupByDepartment)
                    {
                        ApplicationArea = All;
                        Caption = 'Group by Department';
                        ToolTip = 'Group employees by department';
                    }

                    field(GroupByPosition; GroupByPosition)
                    {
                        ApplicationArea = All;
                        Caption = 'Group by Position';
                        ToolTip = 'Group employees by position';
                    }
                }

                group(Sorting)
                {
                    Caption = 'Sorting';

                    field(SortBy; SortBy)
                    {
                        ApplicationArea = All;
                        Caption = 'Sort By';
                        ToolTip = 'Select how to sort the payroll entries';
                        OptionCaption = 'Employee No.,Employee Name,Department,Net Salary';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            UpdateReportOptions();
        end;
    }

    trigger OnInitReport()
    begin
        ReportType := ReportType::"Detailed Payroll";
        IncludeEmployeeDetails := true;
        IncludeStatutoryInfo := false;
        IncludeBankDetails := false;
        ShowSummaryTotals := true;
        OneEmployeePerPage := false;
        GroupByDepartment := false;
        GroupByPosition := false;
        SortBy := SortBy::"Employee No.";
    end;

    trigger OnPreReport()
    begin
        // Set sorting based on selection
        case SortBy of
            SortBy::"Employee No.":
                PayrollEntry.SetCurrentKey("Employee No.");
            SortBy::"Employee Name":
                PayrollEntry.SetCurrentKey("Employee Name");
            SortBy::Department:
                begin
                    PayrollEntry.SetCurrentKey("Employee No.");
                    // Department sorting will be handled in the report layout
                end;
            SortBy::"Net Salary":
                PayrollEntry.SetCurrentKey("Net Salary");
        end;
    end;

    local procedure UpdateReportOptions()
    begin
        case ReportType of
            ReportType::"Payroll Summary":
                begin
                    IncludeEmployeeDetails := true;
                    IncludeBankDetails := false;
                    ShowSummaryTotals := true;
                    OneEmployeePerPage := false;
                end;
            ReportType::Payslip:
                begin
                    IncludeEmployeeDetails := true;
                    IncludeBankDetails := true;
                    ShowSummaryTotals := false;
                    OneEmployeePerPage := true;
                    GroupByDepartment := false;
                    GroupByPosition := false;
                end;
            ReportType::"Detailed Payroll":
                begin
                    IncludeEmployeeDetails := true;
                    IncludeBankDetails := false;
                    ShowSummaryTotals := true;
                    OneEmployeePerPage := false;
                end;
        end;
    end;

    var
        Employee: Record "HRMS Employee";
        FilterString: Text;
        ReportTitle: Text[100];
        PayrollMonthYear: Text[20];
        TotalBasicSalary: Decimal;
        TotalGrossSalary: Decimal;
        TotalDeductions: Decimal;
        TotalNetSalary: Decimal;
        EmployeeCount: Integer;
        ReportType: Option "Payroll Summary",Payslip,"Detailed Payroll";
        IncludeEmployeeDetails: Boolean;
        IncludeStatutoryInfo: Boolean;
        IncludeBankDetails: Boolean;
        ShowSummaryTotals: Boolean;
        OneEmployeePerPage: Boolean;
        GroupByDepartment: Boolean;
        GroupByPosition: Boolean;
        SortBy: Option "Employee No.","Employee Name",Department,"Net Salary";
}
