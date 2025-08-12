table 50200 "HRMS Leave Type"

{

    Caption = 'Leave Type';



    fields

    {

        field(1; "Code"; Code[20]) { Caption = 'Code'; }

        field(2; "Description"; Text[50]) { Caption = 'Description'; }

        field(10; "Max Days Per Year"; Decimal) { Caption = 'Max Days Per Year'; }

        field(11; "Carry Forward Allowed"; Boolean) { Caption = 'Carry Forward Allowed'; }

        field(12; "Encashment Allowed"; Boolean) { Caption = 'Encashment Allowed'; }

        //field(20; "Accrual Type"; Enum "HRMS Leave Accrual Type") { Caption = 'Accrual Type'; }

    }

}