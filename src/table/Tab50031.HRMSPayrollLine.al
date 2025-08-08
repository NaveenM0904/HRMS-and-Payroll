table 50031 "HRMS Payroll Line"

{

    DataClassification = CustomerContent;

    Caption = 'Payroll Line';



    fields

    {

        field(1; "Payroll Period"; Code[20])

        {

            Caption = 'Payroll Period';

            TableRelation = "HRMS Payroll Header";

        }



        field(2; "Employee No."; Code[20])

        {

            Caption = 'Employee No.';

            TableRelation = "HRMS Employee";

        }



        field(3; "Pay Head Code"; Code[20])

        {

            Caption = 'Pay Head Code';

            TableRelation = "HRMS Pay Head";

        }



        field(10; "Amount"; Decimal)

        {

            Caption = 'Amount';

            DecimalPlaces = 2 : 2;

        }



        field(20; "Pay Head Type"; Enum "HRMS Pay Head Type")

        {

            Caption = 'Pay Head Type';

            Editable = false;

        }

    }



    keys

    {

        key(Key1; "Payroll Period", "Employee No.", "Pay Head Code")

        {

            Clustered = true;

        }

    }

}