// Allows us to use ES6 in our migrations and tests.
require('babel-register')

module.exports = {
  networks: {
    private: {
      host: '127.0.0.1',
      port: 8545,
      network_id: "95518",
	  gas: 1000000000,
	  gasPrice:100000000,
      from: "0x14f434d6a79a3f5d4fb5c3f47fc65a0dc374bb10"
    }
  }
}
