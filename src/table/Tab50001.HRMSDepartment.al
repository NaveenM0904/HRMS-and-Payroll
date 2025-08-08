table 50001 "HRMS Department"

{

    DataClassification = CustomerContent;

    Caption = 'Department';

    // LookupPageId = "HRMS Department List";

    // DrillDownPageId = "HRMS Department List";



    fields

    {

        field(1; "Code"; Code[20])

        {

            Caption = 'Code';

            NotBlank = true;

        }



        field(2; "Name"; Text[50])

        {

            Caption = 'Name';

            NotBlank = true;

        }



        field(3; "Department Head"; Code[20])

        {

            Caption = 'Department Head';

            TableRelation = "HRMS Employee";

        }



        field(4; "Parent Department"; Code[20])

        {

            Caption = 'Parent Department';

            TableRelation = "HRMS Department";

        }



        field(10; "Cost Center Code"; Code[20])

        {

            Caption = 'Cost Center Code';

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }



        field(20; "Blocked"; Boolean)

        {

            Caption = 'Blocked';

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