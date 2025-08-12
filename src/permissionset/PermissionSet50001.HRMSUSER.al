permissionset 50001 "HRMS-USER"

{

    Caption = 'HRMS User';



    Permissions =

        tabledata "HRMS Employee" = R,

        tabledata "HRMS Payroll Line" = R,

        page "Employee List" = X,

        report "HRMS Payslip" = X;

}