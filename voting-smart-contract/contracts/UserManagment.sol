pragma solidity ^0.8.0;

contract UserManagement {
    struct User {
        string email;
        bytes32 passwordHash;
        bool isRegistered;
    }

    mapping(address => User) public users;

    event UserRegistered(address userAddress, string email);

    function registerUser(string memory _email, bytes32 _passwordHash) public {
        require(!users[msg.sender].isRegistered, "User already registered");
        users[msg.sender] = User(_email, _passwordHash, true);
        emit UserRegistered(msg.sender, _email);
    }

    function login(string memory _email, bytes32 _passwordHash) public view returns (bool) {
        User memory user = users[msg.sender];
        return (user.isRegistered && 
                keccak256(abi.encodePacked(user.email)) == keccak256(abi.encodePacked(_email)) && 
                user.passwordHash == _passwordHash);
    }

    function isUserRegistered(address _userAddress) public view returns (bool) {
        return users[_userAddress].isRegistered;
    }
}