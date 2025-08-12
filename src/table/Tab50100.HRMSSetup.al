/// <summary>
/// Table HRMS Setup (ID 50010)
/// Setup table for HRMS configuration
/// </summary>
table 50100 "HRMS Setup"
{
    DataClassification = CustomerContent;
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

        field(11; "Department Nos."; Code[20])
        {
            Caption = 'Department Nos.';
            TableRelation = "No. Series";
        }

        field(12; "Position Nos."; Code[20])
        {
            Caption = 'Position Nos.';
            TableRelation = "No. Series";
        }

        field(13; "Leave Application Nos."; Code[20])
        {
            Caption = 'Leave Application Nos.';
            TableRelation = "No. Series";
        }

        field(14; "Payroll Batch Nos."; Code[20])
        {
            Caption = 'Payroll Batch Nos.';
            TableRelation = "No. Series";
        }

        field(20; "Default Leave Days"; Integer)
        {
            Caption = 'Default Leave Days';
            MinValue = 0;
        }

        field(21; "PF Rate %"; Decimal)
        {
            Caption = 'PF Rate %';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }

        field(22; "ESI Rate %"; Decimal)
        {
            Caption = 'ESI Rate %';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }

        field(23; "Professional Tax"; Decimal)
        {
            Caption = 'Professional Tax';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Primary Key" := '';
    end;
}
