/// <summary>
/// Page HRMS Setup Card (ID 60008)
/// Setup page for HRMS configuration
/// </summary>
page 60008 "HRMS Setup Card"
{
    PageType = Card;
    SourceTable = "HRMS Setup";
    Caption = 'HRMS Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(NumberSeries)
            {
                Caption = 'Number Series';

                field("Employee Nos."; Rec."Employee Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for employees';
                }

                field("Department Nos."; Rec."Department Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for departments';
                }

                field("Position Nos."; Rec."Position Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for positions';
                }

                field("Leave Application Nos."; Rec."Leave Application Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for leave applications';
                }

                field("Payroll Batch Nos."; Rec."Payroll Batch Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for payroll batches';
                }
            }

            group(LeaveSettings)
            {
                Caption = 'Leave Settings';

                field("Default Leave Days"; Rec."Default Leave Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default leave days per year';
                }
            }

            group(PayrollSettings)
            {
                Caption = 'Payroll Settings';

                field("PF Rate %"; Rec."PF Rate %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the PF rate percentage';
                }

                field("ESI Rate %"; Rec."ESI Rate %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ESI rate percentage';
                }

                field("Professional Tax"; Rec."Professional Tax")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the professional tax amount';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
