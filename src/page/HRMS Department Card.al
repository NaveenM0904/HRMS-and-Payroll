
page 60002 "HRMS Department Card"
{
    PageType = Card;
    SourceTable = "HRMS Department";
    Caption = 'Department Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code';
                }

                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Department Head"; Rec."Department Head") { ApplicationArea = All; }
                field("Parent Department"; Rec."Parent Department") { ApplicationArea = All; }
                field("Cost Center Code"; Rec."Cost Center Code") { ApplicationArea = All; }
                field(Blocked; Rec.Blocked) { ApplicationArea = All; }
            }
        }

        area(FactBoxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Department)
            {
                Caption = 'Department';

                action(Employees)
                {
                    Caption = 'Employees';
                    Image = ResourceGroup;
                    ApplicationArea = All;
                    RunObject = Page "Employee List";
                    // RunPageLink = "Department Code" = field("Code");
                    ToolTip = 'View employees in this department';
                }

                action(Positions)
                {
                    Caption = 'Positions';
                    Image = Job;
                    ApplicationArea = All;
                    // RunObject = Page "HRMS Position List";
                    // RunPageLink = "Department Code" = field("Code");
                    ToolTip = 'View positions in this department';
                }
            }
        }

        area(Promoted)
        {
            group(Category_Department)
            {
                Caption = 'Department';

                actionref(Employees_Promoted; Employees)
                {
                }
                actionref(Positions_Promoted; Positions)
                {
                }
            }
        }
    }
}