# YourAltcoin
Script to create your own altcoin based on litecoin code

Important notice:

The litecoin directory here is not just a simple copy of the litecoin code but it was also modified by me in order to make the scripts work properly.

Dependencies to be installed:

Dependencies:
 
1) sudo apt-get install git
2) sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
3) sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
4) sudo apt-get install libboost-all-dev
5) sudo apt-get install software-properties-common
6) sudo add-apt-repository ppa:bitcoin/bitcoin
7) sudo apt-get update
8) sudo apt-get install libdb4.8-dev libdb4.8++-dev
9) sudo apt-get install libminiupnpc-dev
10) sudo apt-get install libzmq3-dev
11) sudo apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler 
12) sudo apt-get install libqt4-dev libprotobuf-dev protobuf-compiler
13) Install xampp for Linux.

Instructions:

1) litecoin directory, script1, script2, script3, script4, otherScripts and img should go in the Desktop.
2) CreateCoin directory should go inside the opt/lampp/htdocs directory.
3) You should change the variables inside scripts to customize your coin.
4) if the scripts are not executable you should apply a chmod 777 script.. to them (for the permissions)
5) You should change the 3 images inside img directory to whatever pictures you like to appear in your wallet.
6) You should also set the hardcoded nodes you wish to run inside otherScripts/listaIn.tx. For this case we are just setting the loopback IP(127.0.0.1) but in case you'll be running the node in a VPS you should want to put the IP of your VPS there so it would be easier the configuration afterwords.
7) ./script1.sh  (run the 1st script in the Desktop and wait... they will start running all sequentially)
8) After approximatly 1 hour you should have your own altcoin and your wallet for Linux. You would be able to export the wallet to other computer (like a VPS), set the nodes (server and clients) and start enjoying your own altcoin.
9) If you want the wallets to work on Windows you would need to do a cross compilation.

For mor information of this and to making it work you can see in my youtube channel (the videos are in spanish but for those of you that don't speak spanish you can just watch the different steps):
1) theory of altcoin (to know which values to change): https://youtu.be/LFUYep3aELs
2) Creating the altcoin: https://youtu.be/7t7mWEU3WoQ
3) setting the nodes and mining: https://youtu.be/VrefzcLfzLk

If you need any help or just having problem with the dependencies you can get in touch with me at cmarchesetdiii@gmail.com and I could send you the enviroment for the virtual machine.

