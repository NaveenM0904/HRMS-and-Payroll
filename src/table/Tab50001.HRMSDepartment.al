
table 50001 "HRMS Department"
{
    DataClassification = CustomerContent;
    Caption = 'Department';
    LookupPageId = "HRMS Department List";
    DrillDownPageId = "HRMS Department List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Code" <> xRec."Code" then begin
                    HRMSSetup.Get();
                    NoSeriesMgt.TestManual(HRMSSetup."Department Nos.");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description';
            NotBlank = true;
        }

        field(3; "Manager Employee No."; Code[20])
        {
            Caption = 'Manager Employee No.';
            TableRelation = "HRMS Employee";
        }

        field(4; "Manager Name"; Text[100])
        {
            Caption = 'Manager Name';
            Editable = false;
        }

        field(10; Active; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }

        field(20; "No. of Employees"; Integer)
        {
            Caption = 'No. of Employees';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("HRMS Employee" where("Department Code" = field("Code"), Status = const(Active)));
        }

        field(30; "No. Series"; Code[20])
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

        field(102; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            Editable = false;
        }

        field(103; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
    }

    trigger OnInsert()
    begin
        if "Code" = '' then begin
            HRMSSetup.Get();
            HRMSSetup.TestField("Department Nos.");
            "Code" := NoSeriesMgt.GetNextNo(HRMSSetup."Employee Nos.", WorkDate, true);
            // NoSeriesMgt.(HRMSSetup."Department Nos.", xRec."No. Series", 0D, "Code", "No. Series");
        end;

        "Creation Date" := Today;
        "Created By" := UserId;
    end;

    trigger OnModify()
    begin
        "Modified Date" := Today;
        "Modified By" := UserId;
    end;

    trigger OnDelete()
    var
        Employee: Record "HRMS Employee";
    begin
        Employee.SetRange("Department Code", "Code");
        if not Employee.IsEmpty then
            Error(Text001, "Code");
    end;

    trigger OnRename()
    begin
        Error(Text002, TableCaption);
    end;

    var
        HRMSSetup: Record "HRMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Text001: Label 'You cannot delete Department %1 because employees are assigned to it.';
        Text002: Label 'You cannot rename a %1.';
}
