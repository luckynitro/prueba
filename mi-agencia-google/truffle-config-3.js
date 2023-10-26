module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545, // Puerto de tu nodo Ethereum local (por ejemplo, Ganache)
      network_id: "*" // coincide con cualquier id de red
    }
  },
  compilers: {
    solc: {
      version: "0.8.19", // versión del compilador Solidity que deseas utilizar
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
