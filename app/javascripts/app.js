// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

// Import our contract artifacts and turn them into usable abstractions.
import Myadmin_artifacts from '../../build/contracts/admin.json'

// MetaCoin is our usable abstraction, which we'll use through the code below.
var Myadmin = contract(Myadmin_artifacts);

// The following code is simple to show off interacting with your contracts.
// As your needs grow you will likely need to change its form and structure.
// For application bootstrapping, check out window.addEventListener below.
var accounts;
var account;

window.App = {
  start: function() {
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    Myadmin.setProvider(web3.currentProvider);

    // Get the initial account balance so it can be displayed.
    web3.eth.getAccounts(function(err, accs) {
      if (err != null) {
        alert("There was an error fetching your accounts.");
        return;
      }

      if (accs.length == 0) {
        alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
        return;
      }

      accounts = accs;
      account = accounts[0];
      console.log(account);
    });
  },

  setStatus: function(message) {
    var status = document.getElementById("status");
    status.innerHTML = message;
  },


  addRecord: function() {
      var self = this;
      var meta;
      var id = parseInt(document.getElementById("id").value);
      var date = parseInt(document.getElementById("date").value);
      var hour = parseInt(document.getElementById("hour").value);

      var tmp = Date.parse( new Date() ).toString();
      tmp = parseInt(tmp.substr(0,10));
      Myadmin.deployed().then(function(instance){
          meta = instance;
          return meta.addRecord(id, date, hour,tmp, {from: account});
      }).then(function(res){
          console.log("记录成功");
          console.log(res);
      }).catch(function(e){
        console.log(e);
        self.setStatus("Error");
      });
  },

  getRecords: function() {
      var self = this;
      var meta;

      var id = document.getElementById("id2").value;
      Myadmin.deployed().then(function(instance){
          console.log(instance)
          meta = instance;
          return meta.calHour.call(id);
      }).then(function(total){
          console.log("查询成功");
          console.log(total);
          self.setStatus(total);
      }).catch(function(e){
        console.log(e);
        self.setStatus("Error");
      });
  }
};

window.addEventListener('load', function() {
  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== 'undefined') {
    console.warn("Using web3 detected from external source.")
    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider);
  } else {
    console.warn("No web3 detected.");
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"));
  }

  App.start();
});
