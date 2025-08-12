
page 60005 "HRMS Position List"
{
    PageType = List;
    SourceTable = "HRMS Position";
    Caption = 'Position List';
    CardPageId = "HRMS Position Card";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
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
    }

    actions
    {
        area(Navigation)
        {
            group(Position)
            {
                Caption = 'Position';

                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                    RunObject = Page "HRMS Position Card";
                    RunPageLink = "Position Code" = field("Position Code");
                    ToolTip = 'Open the position card';
                }

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

        area(Processing)
        {
            action(NewPosition)
            {
                Caption = 'New Position';
                Image = NewItem;
                ApplicationArea = All;
                RunObject = Page "HRMS Position Card";
                RunPageMode = Create;
                ToolTip = 'Create a new position';
            }
        }

        area(Promoted)
        {
            group(Category_New)
            {
                Caption = 'New';

                actionref(NewPosition_Promoted; NewPosition)
                {
                }
            }

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