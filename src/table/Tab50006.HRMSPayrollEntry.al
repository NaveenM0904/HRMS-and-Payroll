
table 50006 "HRMS Payroll Entry"
{
    DataClassification = CustomerContent;
    Caption = 'Payroll Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(2; "Payroll Batch No."; Code[20])
        {
            Caption = 'Payroll Batch No.';
            NotBlank = true;
        }

        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "HRMS Employee";
            NotBlank = true;
        }

        field(4; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
        }

        field(10; "Payroll Month"; Integer)
        {
            Caption = 'Payroll Month';
            MinValue = 1;
            MaxValue = 12;
        }

        field(11; "Payroll Year"; Integer)
        {
            Caption = 'Payroll Year';
            MinValue = 1900;
        }

        field(20; "Basic Salary"; Decimal)
        {
            Caption = 'Basic Salary';
            DecimalPlaces = 2 : 2;
        }

        field(21; "HRA"; Decimal)
        {
            Caption = 'HRA';
            DecimalPlaces = 2 : 2;
        }

        field(22; "Medical Allowance"; Decimal)
        {
            Caption = 'Medical Allowance';
            DecimalPlaces = 2 : 2;
        }

        field(23; "Transport Allowance"; Decimal)
        {
            Caption = 'Transport Allowance';
            DecimalPlaces = 2 : 2;
        }

        field(24; "Special Allowance"; Decimal)
        {
            Caption = 'Special Allowance';
            DecimalPlaces = 2 : 2;
        }

        field(25; "Gross Salary"; Decimal)
        {
            Caption = 'Gross Salary';
            DecimalPlaces = 2 : 2;
        }

        field(30; "PF Deduction"; Decimal)
        {
            Caption = 'PF Deduction';
            DecimalPlaces = 2 : 2;
        }

        field(31; "ESI Deduction"; Decimal)
        {
            Caption = 'ESI Deduction';
            DecimalPlaces = 2 : 2;
        }

        field(32; "Professional Tax"; Decimal)
        {
            Caption = 'Professional Tax';
            DecimalPlaces = 2 : 2;
        }

        field(33; "TDS"; Decimal)
        {
            Caption = 'TDS';
            DecimalPlaces = 2 : 2;
        }

        field(34; "Other Deductions"; Decimal)
        {
            Caption = 'Other Deductions';
            DecimalPlaces = 2 : 2;
        }

        field(35; "Total Deductions"; Decimal)
        {
            Caption = 'Total Deductions';
            DecimalPlaces = 2 : 2;
        }

        field(40; "Net Salary"; Decimal)
        {
            Caption = 'Net Salary';
            DecimalPlaces = 2 : 2;
        }

        field(50; "Days Worked"; Decimal)
        {
            Caption = 'Days Worked';
            DecimalPlaces = 2 : 2;
        }

        field(51; "Days in Month"; Integer)
        {
            Caption = 'Days in Month';
        }

        field(52; "Leave Days"; Decimal)
        {
            Caption = 'Leave Days';
            DecimalPlaces = 2 : 2;
        }

        field(60; Processed; Boolean)
        {
            Caption = 'Processed';
            Editable = false;
        }

        field(61; "Processing Date"; Date)
        {
            Caption = 'Processing Date';
            Editable = false;
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
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Payroll Batch No.", "Employee No.")
        {
        }
        key(Key3; "Employee No.", "Payroll Year", "Payroll Month")
        {
        }
    }

    trigger OnInsert()
    begin
        "Creation Date" := Today;
        "Created By" := UserId;
    end;
}
