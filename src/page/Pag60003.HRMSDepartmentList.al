
page 60003 "HRMS Department List"
{
    PageType = List;
    SourceTable = "HRMS Department";
    Caption = 'Department List';
    CardPageId = "HRMS Department Card";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
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

                field("No. of Employees"; Rec."No. of Employees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of employees';
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the department is active';
                }
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

                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                    RunObject = Page "HRMS Department Card";
                    RunPageLink = "Code" = field("Code");
                    ToolTip = 'Open the department card';
                }

                action(Employees)
                {
                    Caption = 'Employees';
                    Image = ResourceGroup;
                    ApplicationArea = All;
                    RunObject = Page "HRMS Employee List";
                    RunPageLink = "Department Code" = field("Code");
                    ToolTip = 'View employees in this department';
                }
            }
        }

        area(Processing)
        {
            action(NewDepartment)
            {
                Caption = 'New Department';
                Image = NewItem;
                ApplicationArea = All;
                RunObject = Page "HRMS Department Card";
                RunPageMode = Create;
                ToolTip = 'Create a new department';
            }
        }

        area(Promoted)
        {
            group(Category_New)
            {
                Caption = 'New';

                actionref(NewDepartment_Promoted; NewDepartment)
                {
                }
            }

            group(Category_Department)
            {
                Caption = 'Department';

                actionref(Employees_Promoted; Employees)
                {
                }
            }
        }
    }
}
