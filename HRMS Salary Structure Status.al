enum 50007 "HRMS Salary Structure Status"
{
    Extensible = true; // allow adding more status values later

    value(0; Draft)
    {
        Caption = 'Draft';
    }
    value(1; Active)
    {
        Caption = 'Active';
    }
    value(2; Inactive)
    {
        Caption = 'Inactive';
    }
    value(3; Closed)
    {
        Caption = 'Closed';
    }
}