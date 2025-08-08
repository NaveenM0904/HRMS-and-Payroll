enum 50005 "HRMS Marital Status"
{
    Extensible = true; // Allows adding more values later if needed

    value(0; "Not Specified")
    {
        Caption = 'Not Specified';
    }
    value(1; Married)
    {
        Caption = 'Married';
    }
    value(2; Unmarried)
    {
        Caption = 'Unmarried';
    }

}