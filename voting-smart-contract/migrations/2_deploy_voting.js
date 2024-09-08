const Voting = artifacts.require("Voting");

module.exports = function (deployer) {
    const candidates = ["Alice", "Bob", "Charlie"]; // Add your candidates here
    deployer.deploy(Voting, candidates);
};