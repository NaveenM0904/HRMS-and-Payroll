page 60001 "HRMS Employee Card"

{

    Caption = 'Employee Card';

    PageType = Card;

    SourceTable = "HRMS Employee";



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



                    trigger OnAssistEdit()

                    begin

                        // if Rec.AssistEdit(xRec) then
                        //     CurrPage.Update();

                    end;

                }



                field("First Name"; Rec."First Name")

                {

                    ApplicationArea = All;



                    trigger OnValidate()

                    begin

                        CurrPage.Update();

                    end;

                }



                field("Last Name"; Rec."Last Name")

                {

                    ApplicationArea = All;



                    trigger OnValidate()

                    begin

                        CurrPage.Update();

                    end;

                }



                field("Full Name"; Rec."Full Name")

                {

                    ApplicationArea = All;

                }



                field("Employment Date"; Rec."Employment Date")

                {

                    ApplicationArea = All;

                }



                field(Status; Rec.Status)

                {

                    ApplicationArea = All;

                }

            }



            group("Job Information")

            {

                Caption = 'Job Information';



                field("Department Code"; Rec."Department Code")

                {

                    ApplicationArea = All;

                }



                field("Position Code"; Rec."Position Code")

                {

                    ApplicationArea = All;

                }



                field("Manager Employee No."; Rec."Manager Employee No.")

                {

                    ApplicationArea = All;

                }

            }



            group("Personal Information")

            {

                Caption = 'Personal Information';



                field("Birth Date"; Rec."Birth Date")

                {

                    ApplicationArea = All;

                }



                field(Gender; Rec.Gender)

                {

                    ApplicationArea = All;

                }



                field("Marital Status"; Rec."Marital Status")

                {

                    ApplicationArea = All;

                }

            }



            group("Contact Information")

            {

                Caption = 'Contact Information';



                field(Address; Rec.Address)

                {

                    ApplicationArea = All;

                }



                field("Address 2"; Rec."Address 2")

                {

                    ApplicationArea = All;

                }



                field(City; Rec.City)

                {

                    ApplicationArea = All;

                }



                field("Post Code"; Rec."Post Code")

                {

                    ApplicationArea = All;

                }



                field("Phone No."; Rec."Phone No.")

                {

                    ApplicationArea = All;

                }



                field("E-Mail"; Rec."E-Mail")

                {

                    ApplicationArea = All;

                }

            }



            group("Banking Information")

            {

                Caption = 'Banking Information';



                field("Bank Account No."; Rec."Bank Account No.")

                {

                    ApplicationArea = All;

                }



                field("Bank Name"; Rec."Bank Name")

                {

                    ApplicationArea = All;

                }



                field("IFSC Code"; Rec."IFSC Code")

                {

                    ApplicationArea = All;

                }

            }



            group("Payroll Information")

            {

                Caption = 'Payroll Information';



                field("Salary Structure Code"; Rec."Salary Structure Code")

                {

                    ApplicationArea = All;

                }



                field("Basic Salary"; Rec."Basic Salary")

                {

                    ApplicationArea = All;

                }

            }



            group("Statutory Information")

            {

                Caption = 'Statutory Information';



                field("PAN No."; Rec."PAN No.")

                {

                    ApplicationArea = All;

                }



                field("PF No."; Rec."PF No.")

                {

                    ApplicationArea = All;

                }



                field("ESI No."; Rec."ESI No.")

                {

                    ApplicationArea = All;

                }

            }

        }



        area(FactBoxes)

        {

            // part("Employee Statistics"; "HRMS Employee Statistics")

            // {

            //     ApplicationArea = All;

            //     SubPageLink = "Employee No." = FIELD("No.");

            // }

        }

    }



    actions

    {

        area(Processing)

        {

            action("Generate Payslip")

            {

                Caption = 'Generate Payslip';

                Image = Print;

                ApplicationArea = All;



                trigger OnAction()

                var

                    PayslipReport: Report "HRMS Payslip";

                begin

                    // PayslipReport.SetEmployee(Rec);

                    PayslipReport.Run();

                end;

            }



            action("Salary Structure")

            {

                Caption = 'Salary Structure';

                Image = Sales;

                ApplicationArea = All;



                trigger OnAction()

                var

                    SalaryStructure: Record "HRMS Salary Structure";

                // SalaryStructurePage: Page "HRMS Salary Structure Card";

                begin

                    if Rec."Salary Structure Code" <> '' then begin

                        SalaryStructure.Get(Rec."Salary Structure Code");

                        // SalaryStructurePage.SetRecord(SalaryStructure);

                        // SalaryStructurePage.Run();

                    end;

                end;

            }

        }



        area(Navigation)

        {

            action("Employee Ledger Entries")

            {

                Caption = 'Employee Ledger Entries';

                Image = LedgerEntries;

                // RunObject = Page "HRMS Employee Ledger Entries";

                // RunPageLink = "Employee No." = FIELD("No.");

                ApplicationArea = All;

            }

        }

    }

}