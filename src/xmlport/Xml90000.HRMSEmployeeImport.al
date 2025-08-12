xmlport 90000 "HRMS Employee Import"

{

    Caption = 'Employee Import';

    Direction = Import;

    Format = VariableText;

    FormatEvaluate = Legacy;



    schema

    {

        textelement(Root)

        {

            tableelement(Employee; "HRMS Employee")

            {

                XmlName = 'Employee';



                fieldelement(EmployeeNo; Employee."No.")

                {

                }



                fieldelement(FirstName; Employee."First Name")

                {

                }



                fieldelement(LastName; Employee."Last Name")

                {

                }



                fieldelement(EmploymentDate; Employee."Employment Date")

                {

                }



                fieldelement(Department; Employee."Department Code")

                {

                }



                fieldelement(Position; Employee."Position Code")

                {

                }



                fieldelement(BasicSalary; Employee."Basic Salary")

                {

                }



                trigger OnBeforeInsertRecord()

                begin

                    Employee."Full Name" := Employee."First Name" + ' ' + Employee."Last Name";

                    Employee.Status := Employee.Status::Active;

                end;

            }

        }

    }

}