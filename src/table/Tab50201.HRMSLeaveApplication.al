table 50251 "HRMS Leave Application"

{

    Caption = 'Leave Application';



    fields

    {

        field(1; "Application No."; Code[20]) { Caption = 'Application No.'; }

        field(2; "Employee No."; Code[20]) { Caption = 'Employee No.'; }

        field(10; "Leave Type"; Code[20]) { Caption = 'Leave Type'; }

        field(11; "From Date"; Date) { Caption = 'From Date'; }

        field(12; "To Date"; Date) { Caption = 'To Date'; }

        //field(20; "Status"; Enum "HRMS Leave Status") { Caption = 'Status'; }

        field(21; "Approved By"; Code[50]) { Caption = 'Approved By'; }

    }

}