pragma solidity ^0.4.16;
pragma experimental ABIEncoderV2;
contract admin{
    struct Record{
        uint8 date;       //work date
        uint8 count;       //work hour
        uint8 add_time;     // the time add(linux timestamp)
    }
    
    mapping (uint16 => Record[]) public records;
    
    function addRecord(uint16 workerId,uint8 date,uint8 count,uint8 add_time) public{
        Record memory new_record = Record(date,count,add_time);
        records[workerId].push(new_record);         //add a new record
    }
    
    function getRecords(uint16 workerId) public returns (uint) {
        return records[workerId].length;
    }
    
    function calHour(uint16 workerId) public returns (uint8) {
        uint8 num;
        for(uint i = 0; i < records[workerId].length; i++) {
            num  = num+records[workerId][i].count;
        }
        return num;
    }
}