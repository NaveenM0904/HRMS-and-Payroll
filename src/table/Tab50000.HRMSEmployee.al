table 50000 "HRMS Employee"

{

    DataClassification = CustomerContent;

    Caption = 'Employee';

    DrillDownPageId = "Employee List";

    LookupPageId = "Employee List";



    fields

    {

        field(1; "No."; Code[20])

        {
            Caption = 'Employee No.';

            NotBlank = true;

            trigger OnValidate()

            begin

                if "No." <> xRec."No." then begin

                    HRMSSetup.Get();

                    NoSeries.TestManual(HRMSSetup."Employee Nos.");

                    "No. Series" := '';

                end;

            end;

        }
        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';
            NotBlank = true;
        }

        field(3; "Last Name"; Text[50])
        {
            Caption = 'Last Name';

            NotBlank = true;

        }



        field(4; "Full Name"; Text[100])

        {

            Caption = 'Full Name';

            Editable = false;

        }



        field(10; "Employment Date"; Date)

        {

            Caption = 'Employment Date';

            NotBlank = true;

        }



        field(11; Status; Enum "HRMS Employee Status")

        {

            Caption = 'Status';

        }



        field(20; "Department Code"; Code[20])

        {

            Caption = 'Department Code';

            TableRelation = "HRMS Department";

        }



        field(21; "Position Code"; Code[20])

        {

            Caption = 'Position Code';

            TableRelation = "HRMS Position";

        }



        field(30; "Manager Employee No."; Code[20])

        {

            Caption = 'Manager Employee No.';

            TableRelation = "HRMS Employee";

        }



        // Personal Information 

        field(100; "Birth Date"; Date)

        {

            Caption = 'Birth Date';

        }



        field(101; Gender; Enum "HRMS Gender")

        {

            Caption = 'Gender';

        }



        field(102; "Marital Status"; Enum "HRMS Marital Status")

        {

            Caption = 'Marital Status';

        }



        // Contact Information 

        field(200; Address; Text[100])

        {

            Caption = 'Address';

        }



        field(201; "Address 2"; Text[50])

        {

            Caption = 'Address 2';

        }



        field(202; City; Text[30])

        {

            Caption = 'City';

        }



        field(203; "Post Code"; Code[20])

        {

            Caption = 'Post Code';

        }



        field(204; "Phone No."; Text[30])

        {

            Caption = 'Phone No.';

        }



        field(205; "E-Mail"; Text[80])

        {

            Caption = 'E-Mail';

        }



        // Bank Information 

        field(300; "Bank Account No."; Text[30])

        {

            Caption = 'Bank Account No.';

        }



        field(301; "Bank Name"; Text[50])

        {

            Caption = 'Bank Name';

        }



        field(302; "IFSC Code"; Code[20])

        {

            Caption = 'IFSC Code';

        }



        // Payroll Information 

        field(400; "Salary Structure Code"; Code[20])

        {

            Caption = 'Salary Structure Code';

            TableRelation = "HRMS Salary Structure";

        }



        field(401; "Basic Salary"; Decimal)

        {

            Caption = 'Basic Salary';

            DecimalPlaces = 2 : 2;

        }



        // Statutory Information 

        field(500; "PAN No."; Code[20])

        {

            Caption = 'PAN No.';

        }



        field(501; "PF No."; Code[20])

        {

            Caption = 'PF No.';

        }



        field(502; "ESI No."; Code[20])

        {

            Caption = 'ESI No.';

        }
        field(503; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(504; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(505; "Created By"; Code[20])
        {
            Caption = 'Creation By';
        }
        field(506; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
        }
        field(507; "Modified By"; Code[20])
        {
            Caption = 'Modified By';
        }



    }



    keys

    {

        key(Key1; "No.")

        {

            Clustered = true;

        }

        key(Key2; "Department Code")

        {

        }

    }



    trigger OnInsert()

    begin

        if "No." = '' then begin

            HRMSSetup.Get();

            HRMSSetup.TestField("Employee Nos.");

            // NoSeriesMgt.InitSeries(HRMSSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            "No." := NoSeries.GetNextNo(HRMSSetup."Employee Nos.", WorkDate, true);

        end;



        "Creation Date" := Today;

        "Created By" := UserId;

    end;



    trigger OnModify()

    begin


        "Modified Date" := Today;

        "Modified By" := UserId;

    end;



    trigger OnRename()

    begin

        Error(Text001, TableCaption);

    end;



    var

        HRMSSetup: Record "HRMS Setup";

        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Codeunit "No. Series";

        Text001: Label 'You cannot rename a %1.';

}