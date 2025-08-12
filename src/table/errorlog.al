table 50110 "HRMS Error Log"

{

    Caption = 'Error Log';



    fields

    {

        field(1; "Entry No."; Integer)

        {

            Caption = 'Entry No.';

            AutoIncrement = true;

        }



        field(2; "Error Date"; DateTime)

        {

            Caption = 'Error Date';

        }



        field(3; "Error Code"; Code[20])

        {

            Caption = 'Error Code';

        }



        field(4; "Error Message"; Text[250])

        {

            Caption = 'Error Message';

        }



        field(5; "Source Object"; Text[100])

        {

            Caption = 'Source Object';

        }



        field(6; "User ID"; Code[50])

        {

            Caption = 'User ID';

        }

    }



    keys

    {

        key(Key1; "Entry No.")

        {

            Clustered = true;

        }



        key(Key2; "Error Date")

        {

        }

    }

}