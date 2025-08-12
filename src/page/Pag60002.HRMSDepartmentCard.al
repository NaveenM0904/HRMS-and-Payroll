
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

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department description';
                }

                field("Manager Employee No."; Rec."Manager Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the manager employee number';
                }

                field("Manager Name"; Rec."Manager Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the manager name';
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the department is active';
                }

                field("No. of Employees"; Rec."No. of Employees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of employees in the department';
                }
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
                    RunObject = Page "HRMS Employee List";
                    RunPageLink = "Department Code" = field("Code");
                    ToolTip = 'View employees in this department';
                }

                action(Positions)
                {
                    Caption = 'Positions';
                    Image = Job;
                    ApplicationArea = All;
                    RunObject = Page "HRMS Position List";
                    RunPageLink = "Department Code" = field("Code");
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
