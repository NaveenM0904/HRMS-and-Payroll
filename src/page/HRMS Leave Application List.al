
page 60011 "HRMS Leave Application List"
{
    PageType = List;
    SourceTable = "HRMS Leave Application";
    Caption = 'Leave Application List';
    CardPageId = "HRMS Leave Application Card";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the application number';
                }

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee number';
                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee name';
                }

                field("Leave Type Code"; Rec."Leave Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the leave type code';
                }

                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the from date';
                }

                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the to date';
                }

                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of days';
                }

                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the application date';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status';
                }

                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who approved the application';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(LeaveApplication)
            {
                Caption = 'Leave Application';

                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                    RunObject = Page "HRMS Leave Application Card";
                    RunPageLink = "Application No." = field("Application No.");
                    ToolTip = 'Open the leave application card';
                }
            }
        }

        area(Processing)
        {
            action(NewLeaveApplication)
            {
                Caption = 'New Leave Application';
                Image = NewDocument;
                ApplicationArea = All;
                RunObject = Page "HRMS Leave Application Card";
                RunPageMode = Create;
                ToolTip = 'Create a new leave application';
            }

            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                ApplicationArea = All;
                ToolTip = 'Approve selected leave applications';

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Pending then begin
                        if Confirm('Do you want to approve this leave application?') then begin
                            Rec.Approve();
                            CurrPage.Update();
                        end;
                    end else
                        Error('Only pending applications can be approved.');
                end;
            }
        }

        area(Promoted)
        {
            group(Category_New)
            {
                Caption = 'New';

                actionref(NewLeaveApplication_Promoted; NewLeaveApplication)
                {
                }
            }

            group(Category_Process)
            {
                Caption = 'Process';

                actionref(Approve_Promoted; Approve)
                {
                }
            }
        }
    }
}
