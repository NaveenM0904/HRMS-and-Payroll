page 60010 "HRMS Payroll Processing"

{

    Caption = 'Payroll Processing';

    PageType = Card;

    SourceTable = "HRMS Payroll Header";
    UsageCategory = Administration;



    layout

    {

        area(Content)

        {

            group(General)

            {

                Caption = 'General';



                field("Payroll Period"; Rec."Payroll Period")

                {

                    ApplicationArea = All;

                }



                field("Period Start Date"; Rec."Period Start Date")

                {

                    ApplicationArea = All;

                }



                field("Period End Date"; Rec."Period End Date")

                {

                    ApplicationArea = All;

                }



                field(Status; Rec.Status)

                {

                    ApplicationArea = All;

                }

            }



            group("Payroll Summary")

            {

                Caption = 'Payroll Summary';



                field("Total Gross Amount"; Rec."Total Gross Amount")

                {

                    ApplicationArea = All;

                }



                field("Total Deduction Amount"; Rec."Total Deduction Amount")

                {

                    ApplicationArea = All;

                }



                field("Total Net Amount"; Rec."Total Net Amount")

                {

                    ApplicationArea = All;

                }

            }



            // part("Payroll Lines"; "HRMS Payroll Lines")

            // {

            //     ApplicationArea = All;

            //     SubPageLink = "Payroll Period" = FIELD("Payroll Period");

            //     UpdatePropagation = Both;
            // }

        }

    }



    actions

    {

        area(Processing)

        {

            action("Calculate Payroll")

            {

                Caption = 'Calculate Payroll';

                Image = Calculate;

                ApplicationArea = All;



                trigger OnAction()

                var

                    PayrollCalculation: Codeunit "HRMS Payroll Calculation";

                begin

                    PayrollCalculation.CalculatePayroll(Rec);

                    CurrPage.Update();

                end;

            }



            action("Process Payroll")

            {

                Caption = 'Process Payroll';

                Image = Post;

                ApplicationArea = All;



                trigger OnAction()

                var

                    PayrollProcessing: Codeunit "HRMS Payroll Processing";

                begin

                    PayrollProcessing.ProcessPayroll(Rec);

                    CurrPage.Update();

                end;

            }



            action("Generate Payslips")

            {

                Caption = 'Generate Payslips';

                Image = Print;

                ApplicationArea = All;



                trigger OnAction()

                var

                //  PayslipGeneration: Codeunit "HRMS Payslip Generation";

                begin

                    // PayslipGeneration.GeneratePayslips(Rec);

                end;

            }

        }

    }

}
