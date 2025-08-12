page 60500 "HRMS Employee API"

{

    PageType = API;

    EntityCaption = 'Employee';

    EntitySetCaption = 'Employees';

    SourceTable = "HRMS Employee";

    DelayedInsert = true;

    APIPublisher = 'hrms';

    APIGroup = 'employee';

    APIVersion = 'v1.0';

    EntityName = 'employee';

    EntitySetName = 'employees';



    layout

    {

        area(Content)

        {

            repeater(GroupName)

            {

                field(employeeNo; Rec."No.") { }

                field(firstName; Rec."First Name") { }

                field(lastName; Rec."Last Name") { }

                field(fullName; Rec."Full Name") { }

                field(employmentDate; Rec."Employment Date") { }

                field(status; Rec.Status) { }

                field(departmentCode; Rec."Department Code") { }

                field(basicSalary; Rec."Basic Salary") { }

            }

        }

    }

}