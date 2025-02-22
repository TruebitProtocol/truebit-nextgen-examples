const fs = require('fs');
const elliptic = require('elliptic');
const EC = elliptic.ec;
const keccak256 = require('js-sha3').keccak256;
const BN = require('bn.js');

// Example of test data
// const address = '0x0c1622dddb1727c2595e93f31113c6ee30482160';
// const privateKey = '6ee2615d1a1f19abe94aadaf06a07be0a60e9bab628a98b9eae4b9ae894fdb57';
// const publicKey = '04ba60b23a962bc2ab493486da78a1bfcc2f483479cd933123e3f5fd088b6e10f6c2ebaefb221904990fdd73b8602253430b23da826a8fee27fbc8484db44488fe';
// const testString = 'test-ecdsa';
// const testStringHash = '4c4c4c97348eb9904a15bd8608fe9fc3a80aee1e52596aacf29fb23cdf269351';
// const signature = '{"v":27,"r":"d1205f5dfc2e521c2ecb1f5d67de21a805b403a756a769355c993044ce2825c8","s":"4055a18b394e7ae00f71f0864c92e1d3db6c0db758c85dd554a4659bfb9c0216"}';

const ec = new EC('secp256k1');

function isValidSignature(message, signature, address) {
    const msgHash = keccak256(message);
    const bnHash = new BN(msgHash, 16);
    const hashInDecimal = bnHash.toString(10); // Needed because, weirdly, EC.recoverPubKey takes the hash in decimal
    let signatureObject = JSON.parse(signature);
    const recoveryByteV = signatureObject.v - 27;

    const pubKeyRecovered = ec.recoverPubKey(hashInDecimal, signatureObject, recoveryByteV).encode('hex');
    const pubKeyHash = keccak256(Buffer.from(pubKeyRecovered.slice(2), 'hex'));
    const derivedAddress = '0x' + pubKeyHash.slice(-40);

    return derivedAddress.toLowerCase() === address.toLowerCase();
}

const main = () => {
    const input = fs.readFileSync('input.txt', 'utf-8');
    const params = input.split(/\r?\n/);
    const signedValue = params[0];
    const ecdsaSignature = params[1];
    const address = params[2];
    const result = isValidSignature(signedValue, ecdsaSignature, address);

    fs.writeFileSync('output.txt', Buffer.from(result.toString()));
    console.log(result);
}

main();


