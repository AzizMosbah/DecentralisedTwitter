
const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners(); // get the address of contract owner and a random wallet
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal"); //
    
    const waveContract = await waveContractFactory.deploy({
      value: hre.ethers.utils.parseEther("0.1"),
    }); // go and deploy my contract and fund it with .1 ether
    

    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);
    let contractBalance = await hre.ethers.provider.getBalance(
      waveContract.address
    );

    console.log("Contract deployed by:", owner.address);

    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    );

    let waveTxn1 = await waveContract.wave("This is wave #1")
    await waveTxn1.wait()

    let waveTxn2 = await waveContract.wave("This is wave #2")
    await waveTxn2.wait()

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    )
  

    let allWaves = await waveContract.getAllWaves();

    console.log(allWaves);
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
  