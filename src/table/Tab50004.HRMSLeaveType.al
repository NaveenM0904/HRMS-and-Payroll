
table 50004 "HRMS Leave Type"
{
    DataClassification = CustomerContent;
    Caption = 'Leave Type';

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

        field(10; "Max Days Per Year"; Integer)
        {
            Caption = 'Max Days Per Year';
            MinValue = 0;
        }

        field(11; "Carry Forward Allowed"; Boolean)
        {
            Caption = 'Carry Forward Allowed';
        }

        field(12; "Max Carry Forward Days"; Integer)
        {
            Caption = 'Max Carry Forward Days';
            MinValue = 0;
        }

        field(20; "Paid Leave"; Boolean)
        {
            Caption = 'Paid Leave';
            InitValue = true;
        }

        field(21; "Gender Specific"; Enum "HRMS Gender")
        {
            Caption = 'Gender Specific';
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
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Creation Date" := Today;
        "Created By" := UserId;
    end;
}
