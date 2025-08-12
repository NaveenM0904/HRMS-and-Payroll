permissionset 50000 "HRMS-ADMIN" 

{ 

    Caption = 'HRMS Administrator'; 

     

    Permissions =  

        tabledata "HRMS Employee" = RIMD, 

        tabledata "HRMS Department" = RIMD, 

        tabledata "HRMS Position" = RIMD, 

        tabledata "HRMS Pay Head" = RIMD, 

        tabledata "HRMS Salary Structure" = RIMD, 

        tabledata "HRMS Payroll Header" = RIMD, 

        tabledata "HRMS Payroll Line" = RIMD, 

        table "HRMS Employee" = X, 

        table "HRMS Department" = X, 

        page "HRMS Employee Card" = X, 

        page "Employee List" = X, 

        page "HRMS Payroll Processing" = X, 

        report "HRMS Payslip" = X, 

        codeunit "HRMS Payroll Calculation" = X; 

} 

 