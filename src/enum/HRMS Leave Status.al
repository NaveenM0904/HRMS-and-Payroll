/// <summary>
/// Enum for Leave Status
/// </summary>
enum 50016 "HRMS Leave Status"
{
    Extensible = true;

    value(0; Pending)
    {
        Caption = 'Pending';
    }
    value(1; Approved)
    {
        Caption = 'Approved';
    }
    value(2; Rejected)
    {
        Caption = 'Rejected';
    }
    value(3; Cancelled)
    {
        Caption = 'Cancelled';
    }
}
