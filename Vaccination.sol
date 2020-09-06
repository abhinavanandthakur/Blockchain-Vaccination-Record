pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;
contract VaccinationCenter {
    
    struct Vaccination{
        string name;
        uint time;
    }
    address public owner;
    mapping(address  => uint) private UserType;
    mapping(address  => mapping (uint =>Vaccination)) public UserVaccination;
    mapping(address  => uint) public UserVaccinationCount;
    
    constructor() public {
    
        owner = msg.sender;
    }
    
    modifier OnlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    modifier OnlyVaccinationCenter(){
        require(UserType[msg.sender] == 0);
        _;
    }
  
    
    function SetAdressType(address _user, uint _type) OnlyOwner public
    {
       UserType[_user]= _type;
    }
    
    
   
    function SetVaccination(address _user, string _vaccination) OnlyVaccinationCenter public
    {
       UserVaccinationCount[_user]++;
       UserVaccination[_user][UserVaccinationCount[_user]].name = _vaccination;
       UserVaccination[_user][UserVaccinationCount[_user]].time= now;
    }
    
    function GetVaccination(address _user) OnlyVaccinationCenter public returns(string[1][])
    {
      
       
       string[1][] vaccinationlist;
       
       for (uint i=1; i<UserVaccinationCount[_user]; i++) {
           vaccinationlist.push([UserVaccination[_user][i].name]);
        
    }
      return(vaccinationlist);
    }
    
  
}
