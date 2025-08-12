page 50032 "HRMS Salary Structure List"
{
    PageType = List;
    SourceTable = "HRMS Salary Structure";
    Caption = 'Salary Structure List';
    CardPageId = "HRMS Salary Structure Card";
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
                    ToolTip = 'Specifies the salary structure code';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the salary structure description';
                }

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
                    ToolTip = 'Specifies the medical allowance';
                }

                field("Transport Allowance"; Rec."Transport Allowance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the transport allowance';
                }

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

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the salary structure is active';
                }
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

                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                    RunObject = Page "HRMS Salary Structure Card";
                    RunPageLink = "Code" = field("Code");
                    ToolTip = 'Open the salary structure card';
                }
            }
        }

        area(Processing)
        {
            action(NewSalaryStructure)
            {
                Caption = 'New Salary Structure';
                Image = NewItem;
                ApplicationArea = All;
                RunObject = Page "HRMS Salary Structure Card";
                RunPageMode = Create;
                ToolTip = 'Create a new salary structure';
            }
        }

        area(Promoted)
        {
            group(Category_New)
            {
                Caption = 'New';

                actionref(NewSalaryStructure_Promoted; NewSalaryStructure)
                {
                }
            }
        }
    }
}