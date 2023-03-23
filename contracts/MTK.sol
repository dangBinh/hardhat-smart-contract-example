//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.17;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol';
import '@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol';

// https://docs.openzeppelin.com/contracts/4.x/api/token/erc20#ERC20PresetMinterPauser
// https://docs.openzeppelin.com/contracts/4.x/api/token/erc20#ERC20Capped
contract MTK is ERC20PresetMinterPauser, ERC20Capped {
  constructor(
    uint256 initialSupply
  ) ERC20PresetMinterPauser('My Token', 'MTK') ERC20Capped(1000000 * 10 ** 18) {
    ERC20._mint(msg.sender, initialSupply);
  }

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal virtual override(ERC20, ERC20PresetMinterPauser) {
    super._beforeTokenTransfer(from, to, amount);
  }

  function _mint(address to, uint256 amount) internal virtual override(ERC20, ERC20Capped) {
    ERC20Capped._mint(to, amount);
  }
}
