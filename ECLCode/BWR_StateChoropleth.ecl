IMPORT $;
Vehicle := $.File_Vehicle.File;

MyRec := RECORD
 Vehicle.Orig_state;
 TypeCnt := COUNT(GROUP);
END;

MyTable := TABLE(Vehicle,MyRec,Orig_state);

OUTPUT(Sort(MyTable,Orig_state),ALL,NAMED('State_Choro'));


