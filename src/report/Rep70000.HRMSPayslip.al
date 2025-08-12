report 70000 "HRMS Payslip"

{

    Caption = 'Payslip';

    DefaultLayout = RDLC;

    RDLCLayout = './Reports/Payslip.rdl';



    dataset

    {

        dataitem(Employee; "HRMS Employee")

        {

            RequestFilterFields = "No.";



            column(CompanyName; CompanyProperty.DisplayName())

            {

            }



            column(EmployeeNo; "No.")

            {

            }



            column(EmployeeName; "Full Name")

            {

            }



            column(Department; "Department Code")

            {

            }



            column(Position; "Position Code")

            {

            }



            dataitem(PayrollLine; "HRMS Payroll Line")

            {

                DataItemLink = "Employee No." = FIELD("No.");

                DataItemLinkReference = Employee;



                column(PayHeadCode; "Pay Head Code")

                {

                }



                column(PayHeadDescription; PayHeadDescription)

                {

                }



                column(Amount; Amount)

                {

                }



                column(PayHeadType; "Pay Head Type")

                {

                }



                trigger OnAfterGetRecord()

                var

                    PayHead: Record "HRMS Pay Head";

                begin

                    if PayHead.Get("Pay Head Code") then
                        PayHeadDescription := PayHead.Description;

                end;

            }

        }

    }



    requestpage

    {

        layout

        {

            area(Content)

            {

                group(Options)

                {

                    field(PayrollPeriod; PayrollPeriodFilter)

                    {

                        Caption = 'Payroll Period';

                        TableRelation = "HRMS Payroll Header";

                    }

                }

            }

        }

    }



    trigger OnPreReport()

    begin

        if PayrollPeriodFilter <> '' then begin

            PayrollLine.SetRange("Payroll Period", PayrollPeriodFilter);

        end;

    end;



    var

        PayHeadDescription: Text[50];

        PayrollPeriodFilter: Code[20];

}