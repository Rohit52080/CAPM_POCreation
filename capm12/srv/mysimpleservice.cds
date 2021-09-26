using { rohit.db.master, rohit.db.transaction } from '../db/datamodel';

service mysrvdemo {

    function somesrv(msg: String) returns String;

    @readonly
    entity ReadEmployeeSrv as projection on master.employees;
    @insertonly
    entity InsertEmployeeSrv as projection on master.employees;
    @updateonly
    entity UpdateEmployeeSrv as projection on master.employees;
    @deleteonly
    entity DeleteEmployeeSrv as projection on master.employees;


}