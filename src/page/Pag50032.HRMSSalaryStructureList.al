page 50032 "HRMS Salary Structure List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HRMS Salary Structure";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Grade Code"; Rec."Grade Code") { }
                field("Effective From Date"; Rec."Effective From Date") { }
                field("Effective To Date"; Rec."Effective To Date") { }
                field(Status; Rec.Status) { }
                field("Total Fixed Amount"; Rec."Total Fixed Amount") { }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}