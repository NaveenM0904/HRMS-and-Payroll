table 50020 "HRMS Pay Head"

{

    DataClassification = CustomerContent;

    Caption = 'Pay Head';

    // LookupPageId = "HRMS Pay Head List";



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



        field(10; "Pay Head Type"; Enum "HRMS Pay Head Type")

        {

            Caption = 'Pay Head Type';

        }



        field(11; "Calculation Type"; Enum "HRMS Calculation Type")

        {

            Caption = 'Calculation Type';

        }



        field(20; "Taxable"; Boolean)

        {

            Caption = 'Taxable';

        }



        field(21; "PF Applicable"; Boolean)

        {

            Caption = 'PF Applicable';

        }



        field(22; "ESI Applicable"; Boolean)

        {

            Caption = 'ESI Applicable';

        }



        field(30; "G/L Account No."; Code[20])

        {

            Caption = 'G/L Account No.';

            TableRelation = "G/L Account";

        }



        field(40; "Show in Payslip"; Boolean)

        {

            Caption = 'Show in Payslip';

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