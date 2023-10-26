module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    }
  },
  compilers: {
    solc: {
      version: "0.8.19", // Puedes cambiar la versión de Solidity según tus necesidades
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
