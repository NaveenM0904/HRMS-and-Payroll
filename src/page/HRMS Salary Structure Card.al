page 60006 "HRMS Salary Structure Card"
{
    PageType = Card;
    SourceTable = "HRMS Salary Structure";
    Caption = 'Salary Structure Card';

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
                    ToolTip = 'Specifies the salary structure code';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the salary structure description';
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the salary structure is active';
                }
            }

            group(Components)
            {
                Caption = 'Salary Components';

                field("Basic Salary %"; Rec."Basic Salary %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the basic salary percentage';
                }

                field("HRA %"; Rec."HRA %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HRA percentage';
                }

                field("Medical Allowance"; Rec."Medical Allowance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the medical allowance amount';
                }

                field("Transport Allowance"; Rec."Transport Allowance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the transport allowance amount';
                }

                field("Special Allowance %"; Rec."Special Allowance %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the special allowance percentage';
                }
            }

            group(Deductions)
            {
                Caption = 'Deduction Settings';

                field("PF Applicable"; Rec."PF Applicable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if PF is applicable';
                }

                field("ESI Applicable"; Rec."ESI Applicable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if ESI is applicable';
                }

                field("Professional Tax Applicable"; Rec."Professional Tax Applicable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if Professional Tax is applicable';
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
            group(SalaryStructure)
            {
                Caption = 'Salary Structure';

                action(Employees)
                {
                    Caption = 'Employees';
                    Image = ResourceGroup;
                    ApplicationArea = All;
                    RunObject = Page "HRMS Employee List";
                    RunPageLink = "Salary Structure Code" = field("Code");
                    ToolTip = 'View employees using this salary structure';
                }
            }
        }

        area(Promoted)
        {
            group(Category_SalaryStructure)
            {
                Caption = 'Salary Structure';

                actionref(Employees_Promoted; Employees)
                {
                }
            }
        }
    }
}