clc
clear all
close all
hex_key = 'AAAAAAAAAAAAAAAA';
[bin_key] = hexa2bin( hex_key );
[K1,K2,K3,K4]=key_gen(bin_key);
o_msg='2345AAAAAAAA5123';
[bin_msg]=hexa2bin(o_msg);
[cipher]=encrypt(bin_msg,K1,K2,K3,K4);
[plaintext]=decrypt(cipher,K1,K2,K3,K4);
