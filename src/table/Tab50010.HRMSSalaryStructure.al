table 50010 "HRMS Salary Structure"

{

    DataClassification = CustomerContent;

    Caption = 'Salary Structure';

    // LookupPageId = "HRMS Salary Structure List";

    // DrillDownPageId = "HRMS Salary Structure List";



    fields

    {

        field(1; "Code"; Code[20])

        {

            Caption = 'Code';

            NotBlank = true;

        }



        field(2; "Description"; Text[50])

        {

            Caption = 'Description';

        }


        field(3; "Grade Code"; Code[20])

        {

            Caption = 'Grade Code';

            // TableRelation = "HRMS Grade";

        }



        field(10; "Effective From Date"; Date)

        {

            Caption = 'Effective From Date';

        }



        field(11; "Effective To Date"; Date)

        {

            Caption = 'Effective To Date';

        }



        field(20; "Status"; Enum "HRMS Salary Structure Status")

        {

            Caption = 'Status';

        }



        field(30; "Total Fixed Amount"; Decimal)

        {

            Caption = 'Total Fixed Amount';

            Editable = false;

            // FieldClass = FlowField;

            // CalcFormula = Sum("HRMS Salary Structure Line"."Amount" WHERE("Salary Structure Code" = FIELD(Code),

            //  "Pay Head Type" = CONST(Earning),

            //  "Calculation Type" = CONST("Fixed Amount")));

        }

    }



    keys

    {

        key(Key1; "Code")

        {

            Clustered = true;

        }

    }

}