var main = artifacts.require("./admin.sol");

module.exports = function(deployer) {
  deployer.deploy(main);
};
