import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {
    deployments: { deploy },
    getNamedAccounts,
    ethers,
  } = hre;

  const { deployer } = await getNamedAccounts();

  const { BigNumber } = ethers;
  const decimalFactor = BigNumber.from(10).pow(18);
  const maxSupply = ethers.BigNumber.from(1_000_000).mul(decimalFactor).toString();

  const {
    receipt: { contractAddress },
  } = await deploy('MTK', {
    from: deployer,
    args: [maxSupply],
    log: true,
  });

  await new Promise((resolve) => setTimeout(resolve, 30000));

  await hre.run('verify:verify', {
    address: contractAddress,
    constructorArguments: [maxSupply],
  });
  console.log('Done');
};

export default func;
func.tags = ['MTK'];
