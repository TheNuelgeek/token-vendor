import { DeployFunction } from 'hardhat-deploy/types';
import { parseEther } from 'ethers/lib/utils';
import { HardhatRuntimeEnvironmentExtended } from 'helpers/types/hardhat-type-extensions';
import { ethers } from 'hardhat';

const func: DeployFunction = async (hre: HardhatRuntimeEnvironmentExtended) => {
  const { getNamedAccounts, deployments } = hre as any;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy('YourToken', {
    // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
    from: deployer,
    // args: ["Hello"],
    log: true,
  });

  const yourToken = await ethers.getContract('YourToken', deployer);

  // Todo: transfer tokens to frontend address
  //const result = await yourToken.transfer("0x793304f421b09D8fDa4225d7AAE33483fDA5406F", ethers.utils.parseEther("0") );

  // ToDo: To take ownership of yourContract using the ownable library uncomment next line and add the
  // address you want to be the owner.
  // yourContract.transferOwnership(YOUR_ADDRESS_HERE);
};
export default func;
func.tags = ['YourToken'];
