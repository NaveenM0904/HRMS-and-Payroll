// codeunit 80010 "HRMS Error Management" 

// { 

//     procedure LogError(ErrorMessage: Text; ErrorCode: Code[20]; SourceObject: Text) 

//     var 

//        // ErrorLog: Record "HRMS Error Log"; 

//     begin 

//         ErrorLog.Init(); 

//         //ErrorLog."Entry No." := GetNextErrorLogEntryNo(); 

//         ErrorLog."Error Date" := CurrentDateTime; 

//         ErrorLog."Error Code" := ErrorCode; 

//         ErrorLog."Error Message" := CopyStr(ErrorMessage, 1, MaxStrLen(ErrorLog."Error Message")); 

//         ErrorLog."Source Object" := CopyStr(SourceObject, 1, MaxStrLen(ErrorLog."Source Object")); 

//         ErrorLog."User ID" := UserId; 

//         ErrorLog.Insert(); 

//     end; 

     

//     procedure ShowLastErrors() 

//     var 

//         ErrorLog: Record "HRMS Error Log"; 

//         ErrorLogPage: Page "HRMS Error Log"; 

//     begin 

//         ErrorLog.SetRange("Error Date", CreateDateTime(Today - 7, 0T), CurrentDateTime); 

//         ErrorLogPage.SetTableView(ErrorLog); 

//         ErrorLogPage.Run(); 

//     end; 

// } 

 