pragma solidity ^0.4.18;


import "./Ownable.sol";
import "./SimpleMultiSig.sol";


contract SimpleMultiSigFactory is Ownable, SimpleMultiSig {

    function createSimpleMultiSig(
        uint _threshold,
        address[] _owners
    )
    public
    onlyOwner()
    returns (SimpleMultiSig) {

        // this bit sorts the owner addresses
        // sadly I cannot make this into a function since I cannot return a dynamically sized array
        // I'm using bubble sort at the moment since the array is <= 10 addresses so (hopefully) is not a big deal
        address temp;
        for (uint i = 0; i < _owners.length - 1; i++) {
            for (uint j = 0; j < _owners.length - i - 1; j++) {
                if (_owners[j] > _owners[j+1]) {
                    temp = _owners[j];
                    _owners[j] = _owners[j+1];
                    _owners[j+1] = temp;
                }
            }
        }
        SimpleMultiSig newMultiSig = new SimpleMultiSig(
            _threshold,
            _owners
        );
        return newMultiSig;
    }
}
