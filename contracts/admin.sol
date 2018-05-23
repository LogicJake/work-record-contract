pragma solidity ^0.4.16;
pragma experimental ABIEncoderV2;
contract admin{
    struct Record{
        uint date;
        uint count;
        uint add_time;
    }
    
    mapping (uint =>  uint[])  public works;
    mapping (uint =>  mapping (uint => Record[]))  public records;
    
    function addRecord(uint workerId,uint workId,uint date,uint count,uint addTime) public{
        Record memory new_record = Record(date,count,addTime);
        records[workerId][workId].push(new_record);
        bool exist = false;
        for(uint i = 0; i < works[workerId].length; i++)
        {
            if(works[workerId][i] == workId)
                exist = true;
        }
        if(!exist)
            works[workerId].push(workId);
    }
    
    function recordLength(uint workerId,uint workId) constant public returns (uint) {
        return records[workerId][workId].length;
    }
    
    function getRecordsByWorkerIdAndWorkId(uint workerId,uint workId,uint page) constant public returns (string res,bool finished) {
        uint per_page = 10;
        uint start = (page-1)*per_page;
        uint end = start + per_page;
        if(end > records[workerId][workId].length)
            end = records[workerId][workId].length;
        if(page >= records[workerId][workId].length/per_page)
            finished = true;
        else
            finished = false;
     
        for (uint i = start; i < end; ++i) {
            res = strConcat(res,uint2str(records[workerId][workId][i].date),uint2str(records[workerId][workId][i].count),uint2str(records[workerId][workId][i].add_time));
        }
    }
    
    function getRecordsByWorkerId(uint workerId) constant public returns(uint length){
        for(uint i = 0; i < works[workerId].length; i++)
        {
            uint workId = works[workerId][i];
            length += records[workerId][workId].length;
        }
    }
    
    function strConcat(string _a, string _b,string _c,string _d) pure internal returns (string){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        bytes memory _bd = bytes(_d);
        string memory ret = new string(_ba.length + _bb.length + _bc.length + _bd.length+3);
        bytes memory bret = bytes(ret);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++)bret[k++] = _ba[i];
        bret[k++] = ";";
        for (i = 0; i < _bb.length; i++) bret[k++] = _bb[i];
        bret[k++] = ",";

        for (i = 0; i < _bc.length; i++) bret[k++] = _bc[i];
                bret[k++] = ",";

        for (i = 0; i < _bd.length; i++) bret[k++] = _bd[i];
        return string(ret);
   }  
   
    function uint2str(uint i) pure internal returns (string){
        if (i == 0) return "0";
        uint j = i;
        uint length;
        while (j != 0){
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length - 1;
        while (i != 0){
            bstr[k--] = byte(48 + i % 10);
            i /= 10;
        }
        return string(bstr);
    }
}