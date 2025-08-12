table 50300 "HRMS Job Requisition"

{

    Caption = 'Job Requisition';



    fields

    {

        field(1; "Requisition No."; Code[20]) { Caption = 'Requisition No.'; }

        field(2; "Position Code"; Code[20]) { Caption = 'Position Code'; }

        field(10; "No. of Positions"; Integer) { Caption = 'No. of Positions'; }

        //  field(20; "Status"; Enum "HRMS Requisition Status") { Caption = 'Status'; }

    }

}