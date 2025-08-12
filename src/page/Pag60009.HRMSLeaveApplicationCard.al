
page 60009 "HRMS Leave Application Card"
{
    PageType = Card;
    SourceTable = "HRMS Leave Application";
    Caption = 'Leave Application Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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

                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code';
                }

                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the position code';
                }

                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the application date';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the application';
                }
            }

            group(LeaveDetails)
            {
                Caption = 'Leave Details';

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

                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the reason for leave';
                }
            }

            group(Approval)
            {
                Caption = 'Approval Information';

                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who approved the application';
                }

                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval date';
                }

                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the rejection reason';
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
        area(Processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                ApplicationArea = All;
                Enabled = Rec.Status = Rec.Status::Pending;
                ToolTip = 'Approve the leave application';

                trigger OnAction()
                begin
                    if Confirm('Do you want to approve this leave application?') then begin
                        Rec.Approve();
                        CurrPage.Update();
                    end;
                end;
            }

            action(Reject)
            {
                Caption = 'Reject';
                Image = Reject;
                ApplicationArea = All;
                Enabled = Rec.Status = Rec.Status::Pending;
                ToolTip = 'Reject the leave application';

                // trigger OnAction()
                // var
                //     RejectReason: Text[250];
                // begin
                //     if InputQuery('Reject Leave Application', 'Enter rejection reason:', RejectReason) then begin
                //         if RejectReason <> '' then begin
                //             Rec.Reject(RejectReason);
                //             CurrPage.Update();
                //         end else
                //             Error('Rejection reason must be specified.');
                //     end;
                // end;
            }
        }

        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(Approve_Promoted; Approve)
                {
                }
                actionref(Reject_Promoted; Reject)
                {
                }
            }
        }
    }
}
