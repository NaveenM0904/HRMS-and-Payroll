table 50010 "HRMS Salary Structure"

{
    DataClassification = CustomerContent;
    Caption = 'Salary Structure';
    LookupPageId = "HRMS Salary Structure List";
    DrillDownPageId = "HRMS Salary Structure List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description';
            NotBlank = true;
        }

        field(10; "Basic Salary %"; Decimal)
        {
            Caption = 'Basic Salary %';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            MaxValue = 100;
        }

        field(11; "HRA %"; Decimal)
        {
            Caption = 'HRA %';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            MaxValue = 100;
        }

        field(12; "Medical Allowance"; Decimal)
        {
            Caption = 'Medical Allowance';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }

        field(13; "Transport Allowance"; Decimal)
        {
            Caption = 'Transport Allowance';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }

        field(14; "Special Allowance %"; Decimal)
        {
            Caption = 'Special Allowance %';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            MaxValue = 100;
        }

        field(20; "PF Applicable"; Boolean)
        {
            Caption = 'PF Applicable';
            InitValue = true;
        }

        field(21; "ESI Applicable"; Boolean)
        {
            Caption = 'ESI Applicable';
            InitValue = true;
        }

        field(22; "Professional Tax Applicable"; Boolean)
        {
            Caption = 'Professional Tax Applicable';
            InitValue = true;
        }

        field(30; Active; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
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
        Employee.SetRange("Salary Structure Code", "Code");
        if not Employee.IsEmpty then
            Error(Text001, "Code");
    end;

    var
        Text001: Label 'You cannot delete Salary Structure %1 because employees are assigned to it.';
}
