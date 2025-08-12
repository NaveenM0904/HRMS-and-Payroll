/// <summary>
/// Table HRMS Leave Application (ID 50005)
/// Transaction table for leave applications
/// </summary>
table 50005 "HRMS Leave Application"
{
    DataClassification = CustomerContent;
    Caption = 'Leave Application';
    LookupPageId = "HRMS Leave Application List";
    DrillDownPageId = "HRMS Leave Application List";

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Application No." <> xRec."Application No." then begin
                    HRMSSetup.Get();
                    NoSeriesMgt.TestManual(HRMSSetup."Leave Application Nos.");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "HRMS Employee";
            NotBlank = true;

            trigger OnValidate()
            var
                Employee: Record "HRMS Employee";
            begin
                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."Full Name";
                    "Department Code" := Employee."Department Code";
                    "Position Code" := Employee."Position Code";
                end else begin
                    "Employee Name" := '';
                    "Department Code" := '';
                    "Position Code" := '';
                end;
            end;
        }

        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
        }

        field(4; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            Editable = false;
        }

        field(5; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
            Editable = false;
        }

        field(10; "Leave Type Code"; Code[20])
        {
            Caption = 'Leave Type Code';
            TableRelation = "HRMS Leave Type";
            NotBlank = true;
        }

        field(11; "From Date"; Date)
        {
            Caption = 'From Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                CalculateDays();
            end;
        }

        field(12; "To Date"; Date)
        {
            Caption = 'To Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "To Date" < "From Date" then
                    Error(Text001);
                CalculateDays();
            end;
        }

        field(13; "No. of Days"; Decimal)
        {
            Caption = 'No. of Days';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }

        field(20; Reason; Text[250])
        {
            Caption = 'Reason';
        }

        field(30; Status; Enum "HRMS Leave Status")
        {
            Caption = 'Status';
        }

        field(31; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            Editable = false;
        }

        field(32; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            Editable = false;
        }

        field(33; "Rejection Reason"; Text[250])
        {
            Caption = 'Rejection Reason';
        }

        field(40; "Application Date"; Date)
        {
            Caption = 'Application Date';
            Editable = false;
        }

        field(50; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(100; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }

        field(101; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Application No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "From Date")
        {
        }
        key(Key3; Status)
        {
        }
    }

    trigger OnInsert()
    begin
        if "Application No." = '' then begin
            HRMSSetup.Get();
            HRMSSetup.TestField("Leave Application Nos.");
            NoSeriesMgt.InitSeries(HRMSSetup."Leave Application Nos.", xRec."No. Series", 0D, "Application No.", "No. Series");
        end;

        "Application Date" := Today;
        "Creation Date" := Today;
        "Created By" := UserId;
        Status := Status::Pending;
    end;

    local procedure CalculateDays()
    begin
        if ("From Date" <> 0D) and ("To Date" <> 0D) then
            "No. of Days" := "To Date" - "From Date" + 1;
    end;

    procedure Approve()
    begin
        TestField(Status, Status::Pending);
        Status := Status::Approved;
        "Approved By" := UserId;
        "Approved Date" := Today;
        Modify();
    end;

    procedure Reject(RejectReason: Text[250])
    begin
        TestField(Status, Status::Pending);
        Status := Status::Rejected;
        "Rejection Reason" := RejectReason;
        Modify();
    end;

    var
        HRMSSetup: Record "HRMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: Label 'To Date cannot be earlier than From Date.';
}
