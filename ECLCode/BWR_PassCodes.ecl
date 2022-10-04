IMPORT $;
Vehicle := $.File_Vehicle.File;

MyRec := RECORD
 Vehicle.Orig_state;
 // Vehicle.Vehicle_type;
 TypeCnt := COUNT(GROUP);
END;

// MyTable := TABLE(Vehicle,MyRec,Orig_state,Vehicle_Type);
MyTable := TABLE(Vehicle,MyRec,Orig_state);

OUTPUT(Sort(MyTable,Orig_state),ALL,NAMED('State_Choro'));


