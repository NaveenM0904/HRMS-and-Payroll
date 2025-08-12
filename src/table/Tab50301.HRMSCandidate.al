table 50301 "HRMS Candidate"

{

    Caption = 'Candidate';



    fields

    {

        field(1; "Candidate No."; Code[20]) { Caption = 'Candidate No.'; }

        field(2; "First Name"; Text[50]) { Caption = 'First Name'; }

        field(3; "Last Name"; Text[50]) { Caption = 'Last Name'; }

        field(10; "E-Mail"; Text[80]) { Caption = 'E-Mail'; }

        // field(20; "Application Status"; Enum "HRMS Application Status") { Caption = 'Status'; }

    }

}