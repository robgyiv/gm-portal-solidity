const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const gmContractFactory = await hre.ethers.getContractFactory('GmPortal');
  const gmContract = await gmContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.1'),
  });
  await gmContract.deployed();

  console.log('Contract deployed to:', gmContract.address);
  console.log('Contract deployed by:', owner.address);

  let contractBalance = await hre.ethers.provider.getBalance(gmContract.address);
  console.log('Contract balance:', hre.ethers.utils.formatEther(contractBalance));

  let gmCount;
  gmCount = await gmContract.getTotalGms();
  console.log(gmCount.toNumber());

  let gmTxn = await gmContract.gm('Test message!');
  let gmTxnRateLimited = await gmContract.gm('Test message same person!');
  await gmTxn.wait();
  await gmTxnRateLimited.wait();

  // See how balance has changed
  contractBalance = await hre.ethers.provider.getBalance(gmContract.address);
  console.log('Contract balance:', hre.ethers.utils.formatEther(contractBalance));

  gmCount = await gmContract.getTotalGms();

  gmTxn = await gmContract.connect(randomPerson).gm('Another message!');
  await gmTxn.wait();

  gmCount = await gmContract.getTotalGms();

  let allGms = await gmContract.getAllGms();
  console.log(allGms);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
