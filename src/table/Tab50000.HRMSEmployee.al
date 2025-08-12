
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
                    NoSeriesMgt.TestManual(HRMSSetup."Employee Nos.");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';
            NotBlank = true;

            trigger OnValidate()
            begin
                UpdateFullName();
            end;
        }

        field(3; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
            NotBlank = true;

            trigger OnValidate()
            begin
                UpdateFullName();
            end;
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

            trigger OnValidate()
            var
                Department: Record "HRMS Department";
            begin
                if Department.Get("Department Code") then
                    "Department Name" := Department.Description
                else
                    "Department Name" := '';
            end;
        }

        field(21; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
        }

        field(22; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
            TableRelation = "HRMS Position";

            trigger OnValidate()
            var
                Position: Record "HRMS Position";
            begin
                if Position.Get("Position Code") then
                    "Position Title" := Position."Position Name"
                else
                    "Position Title" := '';
            end;
        }

        field(23; "Position Title"; Text[100])
        {
            Caption = 'Position Title';
            Editable = false;
        }

        field(30; "Manager Employee No."; Code[20])
        {
            Caption = 'Manager Employee No.';
            TableRelation = "HRMS Employee"."No.";

            trigger OnValidate()
            var
                Employee: Record "HRMS Employee";
            begin
                if Employee.Get("Manager Employee No.") then
                    "Manager Name" := Employee."Full Name"
                else
                    "Manager Name" := '';
            end;
        }

        field(31; "Manager Name"; Text[100])
        {
            Caption = 'Manager Name';
            Editable = false;
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

        field(402; "Gross Salary"; Decimal)
        {
            Caption = 'Gross Salary';
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

        field(503; "UAN No."; Code[20])
        {
            Caption = 'UAN No.';
        }

        // Leave Information
        field(600; "Leave Balance"; Decimal)
        {
            Caption = 'Leave Balance';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }

        field(601; "Leave Taken"; Decimal)
        {
            Caption = 'Leave Taken';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }

        // System Fields
        field(700; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(800; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }

        field(801; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }

        field(802; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            Editable = false;
        }

        field(803; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Department Code", "Position Code")
        {
        }
        key(Key3; "Full Name")
        {
        }
        key(Key4; Status)
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRMSSetup.Get();
            HRMSSetup.TestField("Employee Nos.");
            "No." := NoSeriesMgt.GetNextNo(HRMSSetup."Employee Nos.", WorkDate, true);
            // NoSeriesMgt.InitSeries(HRMSSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        UpdateFullName();
        "Creation Date" := Today;
        "Created By" := UserId;
        Status := Status::Active;
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

    local procedure UpdateFullName()
    begin
        "Full Name" := "First Name" + ' ' + "Last Name";
    end;

    var
        HRMSSetup: Record "HRMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Text001: Label 'You cannot rename a %1.';
}
