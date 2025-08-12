
page 60015 "HRMS Employee List"
{
    PageType = List;
    SourceTable = "HRMS Employee";
    Caption = 'Employee List';
    CardPageId = "HRMS Employee Card";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee number';
                }

                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the full name';
                }

                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code';
                }

                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department name';
                }

                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the position code';
                }

                field("Position Title"; Rec."Position Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the position title';
                }

                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employment date';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status';
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the phone number';
                }

                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address';
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
                Visible = false;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Employee)
            {
                Caption = 'Employee';

                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                    RunObject = Page "HRMS Employee Card";
                    RunPageLink = "No." = field("No.");
                    ToolTip = 'Open the employee card';
                }
            }
        }

        // area(Processing)
        // {
        //     // action(NewEmployee)
        //     // {
        //     //     Caption = 'New Employee';
        //     //     Image = NewCustomer;
        //     //     ApplicationArea = All;
        //     //     RunObject = Page "HRMS Employee Card";
        //     //     RunPageMode = Create;
        //     //     ToolTip = 'Create a new employee';
        //     // }
        // }

        area(Reporting)
        {
            action(EmployeeReport)
            {
                Caption = 'Employee Report';
                Image = Report;
                ApplicationArea = All;
                // RunObject = Report "Employee Report";
                ToolTip = 'Print employee report';
            }
        }

        area(Promoted)
        {
            // group(Category_New)
            // {
            //     Caption = 'New';

            //     actionref(NewEmployee_Promoted; NewEmployee)
            //     {
            //     }
            // }

            group(Category_Report)
            {
                Caption = 'Reports';

                actionref(EmployeeReport_Promoted; EmployeeReport)
                {
                }
            }
        }
    }
}
