
page 60001 "HRMS Employee Card"
{
    PageType = Card;
    SourceTable = "HRMS Employee";
    Caption = 'Employee Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee number';
                }

                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first name of the employee';
                }

                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last name of the employee';
                }

                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the full name of the employee';
                }

                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employment date of the employee';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the employee';
                }
            }

            group(Organization)
            {
                Caption = 'Organization';

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
            }

            group(Personal)
            {
                Caption = 'Personal Information';

                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the birth date';
                }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the gender';
                }

                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the marital status';
                }
            }

            group(Contact)
            {
                Caption = 'Contact Information';

                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the address';
                }

                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the address 2';
                }

                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city';
                }

                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the post code';
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

            group(Banking)
            {
                Caption = 'Banking Information';

                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank account number';
                }

                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank name';
                }

                field("IFSC Code"; Rec."IFSC Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the IFSC code';
                }
            }

            group(Payroll)
            {
                Caption = 'Payroll Information';

                field("Salary Structure Code"; Rec."Salary Structure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the salary structure code';
                }

                field("Basic Salary"; Rec."Basic Salary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the basic salary';
                }

                field("Gross Salary"; Rec."Gross Salary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the gross salary';
                }
            }

            group(Statutory)
            {
                Caption = 'Statutory Information';

                field("PAN No."; Rec."PAN No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the PAN number';
                }

                field("PF No."; Rec."PF No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the PF number';
                }

                field("ESI No."; Rec."ESI No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ESI number';
                }

                field("UAN No."; Rec."UAN No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the UAN number';
                }
            }

            group(Leave)
            {
                Caption = 'Leave Information';

                field("Leave Balance"; Rec."Leave Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the leave balance';
                }

                field("Leave Taken"; Rec."Leave Taken")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the leave taken';
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
            group(Employee)
            {
                Caption = 'Employee';

                action(LeaveApplications)
                {
                    Caption = 'Leave Applications';
                    Image = Absence;
                    ApplicationArea = All;
                    RunObject = Page "HRMS Leave Application List";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'View leave applications for this employee';
                }

                action(PayrollEntries)
                {
                    Caption = 'Payroll Entries';
                    Image = PaymentHistory;
                    ApplicationArea = All;
                    // RunObject = Page "HRMS Payroll Entry List";
                    // RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'View payroll entries for this employee';
                }
            }
        }

        area(Processing)
        {
            action(ApplyLeave)
            {
                Caption = 'Apply Leave';
                Image = CreateDocument;
                ApplicationArea = All;
                ToolTip = 'Create a new leave application';

                trigger OnAction()
                var
                    LeaveApplication: Record "HRMS Leave Application";
                    LeaveApplicationCard: Page "HRMS Leave Application Card";
                begin
                    LeaveApplication.Init();
                    LeaveApplication."Employee No." := Rec."No.";
                    LeaveApplication.Validate("Employee No.");
                    LeaveApplication.Insert(true);

                    LeaveApplicationCard.SetRecord(LeaveApplication);
                    LeaveApplicationCard.Run();
                end;
            }
        }

        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ApplyLeave_Promoted; ApplyLeave)
                {
                }
            }

            group(Category_Employee)
            {
                Caption = 'Employee';

                actionref(LeaveApplications_Promoted; LeaveApplications)
                {
                }
                actionref(PayrollEntries_Promoted; PayrollEntries)
                {
                }
            }
        }
    }
}
