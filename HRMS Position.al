table 50032 "HRMS Position"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
            DataClassification = ToBeClassified;

        }
        field(2; "Position Name"; Text[100])
        {
            Caption = 'Position Name';
        }

        field(3; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "HRMS Department"."Code";
        }

        field(5; "Job Grade"; Code[10])
        {
            Caption = 'Job Grade';
        }
        field(7; "Employment Type"; Enum "HRMS Employment Type")
        {
            Caption = 'Employment Type';

        }
        field(8; "Inactive"; Boolean)
        {
            Caption = 'Inactive';
        }
    }

    keys
    {
        key(Key1; "Position Code")
        {
            Clustered = true;
        }
    }



    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}