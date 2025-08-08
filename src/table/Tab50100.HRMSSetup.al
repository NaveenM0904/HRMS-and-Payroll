table 50100 "HRMS Setup"

{

    Caption = 'HRMS Setup';



    fields

    {

        field(1; "Primary Key"; Code[10])

        {

            Caption = 'Primary Key';

        }



        field(10; "Employee Nos."; Code[20])

        {

            Caption = 'Employee Nos.';

            TableRelation = "No. Series";

        }



        field(20; "Payroll Journal Template"; Code[10])

        {

            Caption = 'Payroll Journal Template';

            TableRelation = "Gen. Journal Template";

        }



        field(21; "Payroll Journal Batch"; Code[10])

        {

            Caption = 'Payroll Journal Batch';

            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payroll Journal Template"));

        }



        field(30; "Salary Payable Account"; Code[20])

        {

            Caption = 'Salary Payable Account';

            TableRelation = "G/L Account";

        }



        field(31; "PF Payable Account"; Code[20])

        {

            Caption = 'PF Payable Account';

            TableRelation = "G/L Account";

        }



        field(32; "ESI Payable Account"; Code[20])

        {

            Caption = 'ESI Payable Account';

            TableRelation = "G/L Account";

        }



        field(33; "TDS Payable Account"; Code[20])

        {

            Caption = 'TDS Payable Account';

            TableRelation = "G/L Account";

        }

    }



    keys

    {

        key(Key1; "Primary Key")

        {

            Clustered = true;

        }

    }

}