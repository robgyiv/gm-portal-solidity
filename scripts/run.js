const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const gmContractFactory = await hre.ethers.getContractFactory('GmPortal');
  const gmContract = await gmContractFactory.deploy();
  await gmContract.deployed();

  console.log('Contract deployed to:', gmContract.address);
  console.log('Contract deployed by:', owner.address);

  let gmCount;
  gmCount = await gmContract.getTotalGms();

  let gmTxn = await gmContract.gm();
  await gmTxn.wait();

  gmCount = await gmContract.getTotalGms();

  gmTxn = await gmContract.connect(randomPerson).gm();
  await gmTxn.wait();

  gmCount = await gmContract.getTotalGms();
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
