# Nix derivation to make web3 available

with import <nixpkgs> {};

( let

    ## Standard packages

    pycryptodome = python36.pkgs.pycryptodome;
    pylru = python36.pkgs.pylru;
    requests = python36.pkgs.requests;
    toolz = python36.pkgs.toolz;

    ## Special packages and versions 

    cytoolz= python36.pkgs.buildPythonPackage rec {
      pname = "cytoolz";
      version = "0.9.0";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "5ebb55855a8bb7800afa58e52408763935527e0305f35600c71b43c86013dec2";
      };

      propagatedBuildInputs = [toolz];

      doCheck = false;

    };

    lru-dict = python36.pkgs.buildPythonPackage rec {
      pname = "lru-dict";
      version = "1.1.6";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "365457660e3d05b76f1aba3e0f7fedbfcd6528e97c5115a351ddd0db488354cc";
      };

      doCheck = false;

    };

    rlp = python36.pkgs.buildPythonPackage rec {
      pname = "rlp";
      version = "0.6.0";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "87879a0ba1479b760cee98af165de2eee95258b261faa293199f60742be96f34";
      };

      doCheck = false;

    };
   
    semantic-version = python36.pkgs.buildPythonPackage rec {
      pname = "semantic_version";
      version = "2.6.0";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "2a4328680073e9b243667b201119772aefc5fc63ae32398d6afafff07c4f54c0";
      };

      doCheck = false;

    };

    pysha3= python36.pkgs.buildPythonPackage rec {
      pname = "pysha3";
      version = "1.0.2";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "fe988e73f2ce6d947220624f04d467faf05f1bbdbc64b0a201296bb3af92739e";
      };

      doCheck = false;

      meta.homepage = "https://github.com/tiran/pysha3";

    };

    ## Ethereum oriented packages

    eth-abi = python36.pkgs.buildPythonPackage rec {
      pname = "eth-abi";
      version = "0.5.0";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "ce1d514390b331d7dd63e6f0d9d8fdb289e2f5974e5346dfa91e42aefe452e8e";
      };
      
      propagatedBuildInputs = [eth-utils];

      doCheck = false;

      meta.homepage = "https://github.com/ethereum/eth-abi";

    };

    eth-keyfile = python36.pkgs.buildPythonPackage rec {
      pname = "eth-keyfile";
      version = "0.4.1";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "512b331ca97a4fb0a252a320b85c97c1b675c25026be4e9bc287ca9839828cf8";
      };

      propagatedBuildInputs = [eth-utils eth-keys pycryptodome];

      doCheck = false;

    };

    eth-keys = python36.pkgs.buildPythonPackage rec {
      pname = "eth-keys";
      version = "0.1.0b4";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "5f1fc4830ce0da32e2c7bb5a593c429cc4a257996d3a0db0131894918c88b3dc";
      };

      propagatedBuildInputs = [eth-utils];
      
      doCheck = false;

    };

    eth-utils = python36.pkgs.buildPythonPackage rec {
      pname = "eth-utils";
      version = "0.7.3";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "8be9b39a8db50584086c9165740ea58e49744143a20084c5419430a37940cae6";
      };

      buildInputs = [pysha3 cytoolz];
      propagatedBuildInputs = [pysha3 cytoolz];

      doCheck = false;

      meta.homepage = "https://github.com/ethereum/eth_utils";

    };


    eth-tester = python36.pkgs.buildPythonPackage rec {
      pname = "eth-tester";
      version = "0.1.0b9";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "5174f5abcc757f9b9b1e322b7a56e4fc5a683637cd849f1318376729b84380e4";
      };

      propagatedBuildInputs = [rlp semantic-version eth-utils eth-keys];
      
      doCheck = false;

    };

    ## Web3

    web3 = python36.pkgs.buildPythonPackage rec {
      pname = "web3";
      version = "3.16.4";
      name = "${pname}-${version}";

      src = python36.pkgs.fetchPypi {
        inherit pname version;
        # 4.0.0b4 sha256 = "75aa917e835a49aa8b571f46739800207d1ac68570cd2f0b236db62ba21f8a95";
        sha256 = "b2cff16b7f950acb3c982c0d96e590edb37cd82e2d01d3cb4bed9c0effb7a2e9";
      };

      buildInputs = [pandoc];
      propagatedBuildInputs = [pylru eth-abi eth-tester requests eth-keyfile];

      doCheck = false;

      meta = {
        homepage = "https://github.com/ethereum/web3.py";
      };

    };


  in python36.withPackages (ps: [web3])

).env
