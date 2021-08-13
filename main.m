%%
%clear all
clc
clear all
close all
%%
%Test=0; % for right key encryption
 Test=1; % for key sensitivity test
%image process
Data=imread('baboon.jpg');
Data=rgb2gray(Data);%rgb to gray
%imshow(Data)
IS =256; % Image size
Data=imresize(Data,[IS IS]);
[row,col]=size(Data);
[Data,padding]=scalling(Data,8);
Data_binary=convert2bin(Data);
%% key gen
hex_key = 'AAAAAAAAAAAAAAAA';
[bin_key] = hexa2bin( hex_key );
[K1,K2,K3,K4]=key_gen(bin_key);
%% 
orignal_msg=[];
encrypt_msg=[];
decrypt_msg=[];
%% Encryption Process
%for kk=1:2
  for i=1:size(Data_binary,1)
    orignal=Data_binary(i,:);
    orignal_msg(i,:)=orignal;
    tic
    [cipher]=encrypt(orignal,K1,K2,K3,K4);
    encryption_time(i)=toc;
    encrypt_msg(:,i)=Binary2Dec(cipher);
    cipher_data(i,:)=(cipher);
 %   if(kk<2)
    Data_binary(i,:)=cipher;
  %  end
  end
%if (kk==1)
%D=reshape(encrypt_msg,[row,col]);
%D=D';
%[row,col]=size(D);
%[D,padding]=scalling(D,8);
% Data=[Data Data];
%Data_binary=double(convert2bin(D));
 %   TT=[K1,K2,K3,K4];
%encrypt_msg=[];
%end
%end

%%
%TTT=TT;
if (Test==1)
    fprintf('K=');
 disp(K1);
 K4(end)=~K4(end);
 fprintf('K1=');
 disp(K1);
end
%% Decryption process
%%if (Test==1)
 %%K1(end)=~K1(end);
 %%TT=[K1,K2,K3,K4];
%%end

%for kk=kk:-1:1


%if(kk==2)
  % K11=TT(1:16);K12=TT(17:32);K13=TT(33:48);K14=TT(49:64);
%else
 %   [K11,K12,K13,K14]=key_gen(bin_key);
  %  D=reshape(decrypt_msg,[row,col]);
%D=D';
%[row,col]=size(D);
%[D,padding]=scalling(D,8);
%cipher_data=double(convert2bin(D));
%decrypt_msg=[];
%end
for i=1:size(Data_binary,1)
    cipher=cipher_data(i,:);
    [plaintext]=decrypt(cipher,K1,K2,K3,K4);
    decrypt_msg(:,i)=Binary2Dec(plaintext);
    cipher_data(i,:)=double(plaintext);
end
%end
%%
%image 
Orignal=uint8(reshape(Data,[row,col]));
% 6 Encrypted Image
Encrypted=uint8(reshape(encrypt_msg',[row,col]));
%Encrypted=Encrypted';
Decrypted=uint8(reshape(decrypt_msg,[row,col]));

%%
figure
subplot(1,3,1)
imshow(Orignal)
title('Orignal')
subplot(1,3,2)
imshow(Encrypted)
title('Encrypted')
subplot(1,3,3)
imshow(Decrypted)
title('Decrypted')
%%
% 
% Histogram
figure
subplot(2,1,1)
imhist(Orignal);
subplot(2,1,2)
imhist(Encrypted);

% 14 Image Entropy
Y=(imhist(Encrypted)+0.00001)/(row*col);%(length(Data)-padding);
Y=-sum(Y.*log2(Y));
X=(imhist(Orignal)+0.00001)/(row*col);%(length(Data)-padding);
X=-sum(X.*log2(X));
Re=[X Y]
%  
% 9 Correlation
figure 
subplot(1,2,1)
scatter(Orignal(1:end-1),Orignal(2:end),'.');
axis([0 255 0 255])
subplot(1,2,2)
scatter(Encrypted(1:end-1),Encrypted(2:end),'.')
axis([0 255 0 255])
% 
% % 1 NPCR(%)
NPCR=sum(sum(Encrypted~=Orignal))/(row*col);
% 2 UACI(%) 
UACI=sum(abs(Encrypted-Orignal))/(row*col*255);
disp(NPCR);
disp(UACI);

display(sprintf('Total encryption time: %f\n',sum(encryption_time)));

display('correlation coefficient of original image');
corrcoef(double(Orignal(1:end-1)),double(Orignal(2:end)));
display('correlation coefficient of encrypted image');
corrcoef(double(Encrypted(1:end-1)),double(Encrypted(2:end)));

save('result.mat');
%%

