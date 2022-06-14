// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.10;

import {IPoolAddressesProvider} from '../../interfaces/IPoolAddressesProvider.sol';

contract MockPool {
  // Reserved storage space to avoid layout collisions.
  uint256[100] private ______gap;

  address internal _addressesProvider;
  address[] internal _reserveList;

  uint256 public totalCollateralBase;
  uint256 public totalDebtBase;
  uint256 public availableBorrowsBase;
  uint256 public currentLiquidationThreshold;
  uint256 public ltv;
  uint256 public healthFactor;

  function initialize(address provider) external {
    _addressesProvider = provider;
  }

  function addReserveToReservesList(address reserve) external {
    _reserveList.push(reserve);
  }

  function getReservesList() external view returns (address[] memory) {
    address[] memory reservesList = new address[](_reserveList.length);
    for (uint256 i; i < _reserveList.length; i++) {
      reservesList[i] = _reserveList[i];
    }
    return reservesList;
  }

  function getAddressesProvider() external view returns (address) {
    return _addressesProvider;
  }

  function setUserAccountData(
  uint256 _totalCollateralBase,
  uint256 _totalDebtBase,
  uint256 _availableBorrowsBase,
  uint256 _currentLiquidationThreshold,
  uint256 _ltv,
  uint256 _healthFactor) external {
    totalCollateralBase = _totalCollateralBase,
    totalDebtBase = _totalDebtBase,
    availableBorrowsBase = _availableBorrowsBase,
    currentLiquidationThreshold = _currentLiquidationThreshold,
    ltv = _ltv,
    healthFactor = _healthFactor
    }

    function getUserAccountData(address user)
    external
    view
    returns (
      uint256 totalCollateralBase,
      uint256 totalDebtBase,
      uint256 availableBorrowsBase,
      uint256 currentLiquidationThreshold,
      uint256 ltv,
      uint256 healthFactor
    )
  {}
}

import {Pool} from '../../protocol/pool/Pool.sol';

contract MockPoolInherited is Pool {
  uint16 internal _maxNumberOfReserves = 128;

  function getRevision() internal pure override returns (uint256) {
    return 0x3;
  }

  constructor(IPoolAddressesProvider provider) Pool(provider) {}

  function setMaxNumberOfReserves(uint16 newMaxNumberOfReserves) public {
    _maxNumberOfReserves = newMaxNumberOfReserves;
  }

  function MAX_NUMBER_RESERVES() public view override returns (uint16) {
    return _maxNumberOfReserves;
  }

  function dropReserve(address asset) external override {
    _reservesList[_reserves[asset].id] = address(0);
    delete _reserves[asset];
  }
}
