pragma solidity ^0.4.16;

contract admin{
    struct Record{
        uint date;       //work date
        uint8 count;       //work hour
        uint add_time;     // the time add(linux timestamp)
    }
    
    mapping (uint16 => Record[]) private records;
    
    function addRecord(uint16 workerId,uint date,uint8 count,uint add_time) public{
        Record memory new_record = Record(date,count,add_time);
        records[workerId].push(new_record);         //add a new record
    }
    
    function getRecords(uint16 workerId) public returns (uint) {
        return records[workerId].length;         //add a new record
    }
}