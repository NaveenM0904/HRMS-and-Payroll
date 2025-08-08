table 50030 "HRMS Payroll Header"

{

    DataClassification = CustomerContent;

    Caption = 'Payroll Header';



    fields

    {

        field(1; "Payroll Period"; Code[20])

        {

            Caption = 'Payroll Period';

            NotBlank = true;

        }



        field(2; "Period Start Date"; Date)

        {

            Caption = 'Period Start Date';

        }



        field(3; "Period End Date"; Date)

        {

            Caption = 'Period End Date';

        }



        field(10; "Status"; Enum "HRMS Payroll Status")

        {

            Caption = 'Status';

        }



        field(20; "Total Gross Amount"; Decimal)

        {

            Caption = 'Total Gross Amount';

            Editable = false;

        }



        field(21; "Total Deduction Amount"; Decimal)

        {

            Caption = 'Total Deduction Amount';

            Editable = false;

        }



        field(22; "Total Net Amount"; Decimal)

        {

            Caption = 'Total Net Amount';

            Editable = false;

        }



        field(30; "Processed Date"; Date)

        {

            Caption = 'Processed Date';

        }



        field(31; "Processed By"; Code[50])

        {

            Caption = 'Processed By';

        }

    }



    keys

    {

        key(Key1; "Payroll Period")

        {

            Clustered = true;

        }

    }

}