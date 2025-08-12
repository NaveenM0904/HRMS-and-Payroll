page 60000 "HRMS HR Manager Role Center"

{

    Caption = 'HR Manager';

    PageType = RoleCenter;
    UsageCategory = Administration;



    layout

    {

        area(RoleCenter)

        {

            group(Control1900724808)

            {

                // part(Control1901851508; "HRMS Activities") 

                // { 

                //     ApplicationArea = Basic, Suite; 

                // } 

            }



            group(Control1900724708)

            {

                part(Control1902476008; "Employee List")

                {

                    ApplicationArea = Basic, Suite;

                }



                part(Control1905989608; "My Notifications")

                {

                    ApplicationArea = Basic, Suite;

                }

            }

        }

    }



    actions

    {

        area(Sections)

        {

            group("Employee Management")

            {

                Caption = 'Employee Management';

                action(Employees)

                {

                    Caption = 'Employees';

                    // RunObject = Page "Employee List"; 

                }

                action(Departments)

                {

                    Caption = 'Departments';

                    //  RunObject = Page "HRMS Department List"; 

                }

            }



            group("Payroll")

            {

                Caption = 'Payroll';

                action("Salary Structures")

                {

                    Caption = 'Salary Structures';

                    RunObject = Page "HRMS Salary Structure List";

                }

                action("Pay Heads")

                {

                    Caption = 'Pay Heads';

                    //RunObject = Page "HRMS Pay Head List"; 

                }

                action("Payroll Processing")

                {

                    Caption = 'Payroll Processing';

                    //RunObject = Page "HRMS Payroll List"; 

                }

            }

        }

    }

}