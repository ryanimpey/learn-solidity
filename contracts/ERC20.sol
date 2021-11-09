// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";

contract ERC20 is IERC20 {
    string private _name;
    string private _symbol;
    uint256 private _totalSupply;
    uint8 private constant DECIMAL_COUNT = 18;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor(string memory _tokenName, string memory _tokenSymbol, uint256 _tokenTotalSupply) {
        _name = _tokenName;
        _symbol = _tokenSymbol;
        _totalSupply = _tokenTotalSupply;
    }

    function name() public view virtual override returns(string memory) {
        return _name;
    }

    function symbol() public view virtual override returns(string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns(uint8) {
        return DECIMAL_COUNT;
    }

    function totalSupply() public view virtual override returns(uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view override returns(uint256) {
        return _balances[_owner];
    }

    function _transfer(address _from, address _to, uint256 _value) internal returns(bool) {
        require(_balances[_from] > _value, "Not enough funds");

        _balances[_from] -= _value;
        _balances[_to] += _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    function transfer(address _to, uint256 _value) public override returns(bool) {
        return _transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns(bool) {
       return _transfer(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) external override returns(bool) {
        require(_spender != address(0), "Cannot assign 0 address");
        _allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) external view override returns(uint256 remaining) {
        return _allowances[_owner][_spender];
    }
}