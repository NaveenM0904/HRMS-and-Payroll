codeunit 80020 "HRMS Installation"

{

    Subtype = Install;



    trigger OnInstallAppPerCompany()

    begin

        SetupHRMSMasterData();

        SetupDefaultConfiguration();

    end;



    local procedure SetupHRMSMasterData()

    var

        HRMSSetup: Record "HRMS Setup";

        NoSeries: Record "No. Series";

        NoSeriesLine: Record "No. Series Line";

    begin

        // Create HRMS Setup 

        if not HRMSSetup.Get() then begin

            HRMSSetup.Init();

            HRMSSetup."Primary Key" := '';

            HRMSSetup.Insert();

        end;



        // Create Employee Number Series 

        if not NoSeries.Get('EMP') then begin

            NoSeries.Init();

            NoSeries.Code := 'EMP';

            NoSeries.Description := 'Employee Numbers';

            NoSeries."Default Nos." := true;

            NoSeries.Insert();



            NoSeriesLine.Init();

            NoSeriesLine."Series Code" := 'EMP';

            NoSeriesLine."Line No." := 10000;

            NoSeriesLine."Starting No." := 'EMP00001';

            NoSeriesLine."Ending No." := 'EMP99999';

            NoSeriesLine."Increment-by No." := 1;

            NoSeriesLine.Insert();

        end;



        HRMSSetup."Employee Nos." := 'EMP';

        HRMSSetup.Modify();

    end;



    local procedure SetupDefaultConfiguration()

    begin

        CreateDefaultPayHeads();

        // CreateDefaultDepartments();

    end;



    local procedure CreateDefaultPayHeads()

    var

        PayHead: Record "HRMS Pay Head";

    begin

        // Basic Salary 

        CreatePayHead('BASIC', 'Basic Salary', PayHead."Pay Head Type"::Earning,

                     PayHead."Calculation Type"::"Fixed Amount", true, true, true);



        // House Rent Allowance 

        CreatePayHead('HRA', 'House Rent Allowance', PayHead."Pay Head Type"::Earning,

                     PayHead."Calculation Type"::"Percentage of Basic", true, false, false);



        // Provident Fund Employee 

        CreatePayHead('PF-EE', 'Provident Fund - Employee', PayHead."Pay Head Type"::Deduction,

                     PayHead."Calculation Type"::"Percentage of Basic", false, false, false);



        // ESI Employee 

        CreatePayHead('ESI-EE', 'ESI - Employee', PayHead."Pay Head Type"::Deduction,

                     PayHead."Calculation Type"::"Percentage of Gross", false, false, false);



        // TDS 

        CreatePayHead('TDS', 'Tax Deducted at Source', PayHead."Pay Head Type"::Deduction,

                     PayHead."Calculation Type"::"Formula Based", false, false, false);

    end;



    local procedure CreatePayHead(Code: Code[20]; Description: Text[50]; PayHeadType: Enum "HRMS Pay Head Type";

                                 CalculationType: Enum "HRMS Calculation Type"; Taxable: Boolean;

                                 PFApplicable: Boolean; ESIApplicable: Boolean)

    var

        PayHead: Record "HRMS Pay Head";

    begin

        if not PayHead.Get(Code) then begin

            PayHead.Init();

            PayHead.Code := Code;

            PayHead.Description := Description;

            PayHead."Pay Head Type" := PayHeadType;

            PayHead."Calculation Type" := CalculationType;

            PayHead.Taxable := Taxable;

            PayHead."PF Applicable" := PFApplicable;

            PayHead."ESI Applicable" := ESIApplicable;

            PayHead."Show in Payslip" := true;

            PayHead.Insert();

        end;

    end;

}