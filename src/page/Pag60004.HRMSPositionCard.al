
page 60004 "HRMS Position Card"
{
    PageType = Card;
    SourceTable = "HRMS Position";
    Caption = 'Position Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the position code';
                }

                field("Position Name"; Rec."Position Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the position title';
                }

                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code';
                }

                field("Job Grade"; Rec."Job Grade")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum salary';
                }

                field("Employment Type"; Rec."Employment Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum salary';
                }



                field(Inactive; Rec.Inactive)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the position is active';
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
            group(Position)
            {
                Caption = 'Position';

                action(Employees)
                {
                    Caption = 'Employees';
                    Image = ResourceGroup;
                    ApplicationArea = All;
                    RunObject = Page "HRMS Employee List";
                    RunPageLink = "Position Code" = field("Position Code");
                    ToolTip = 'View employees in this position';
                }
            }
        }

        area(Promoted)
        {
            group(Category_Position)
            {
                Caption = 'Position';

                actionref(Employees_Promoted; Employees)
                {
                }
            }
        }
    }
}