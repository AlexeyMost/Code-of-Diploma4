function [z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,resultsc]=KnutTests(U,lenU)
format long
%___________________________КС-критерий____________________________________
%for i=1:length(y)
   %y(i)=(y(i)-m)/sqrt(D); 
%end
%h=kstest(y)

%__________________________Критерий равномерности__________________________
nravn=1000;
for i=1:(length(U)/nravn)
   for j=1:nravn 
       X(j)=U(nravn*(i-1)+j);
   end
   X=sort(X);
   for j=1:nravn 
       Wravn(j)=(j)/nravn-X(j);
   end
   Kplusravn(i)=sqrt(nravn)*max(Wravn);
end

for i=1:(length(X)/nravn)
t=sqrt(1000)*Kplusravn(i);
PKnp(i)=0;
for k=ceil(t):nravn
    PKnp(i)=PKnp(i)+(factorial(nravn)/(factorial(k)*factorial(nravn-k)))*(k-t)^(k)*(t+nravn-k)^(nravn-k-1); 
end
PKnp(i)=1-(t/nravn^(nravn))*PKnp(i);
end
max(Kplusravn)
min(Kplusravn)





%__________________________Критерий серий__________________________________
fprintf('__________________Критерий серий_______________________________\n\n\n');
dser=14;
for i=1:length(U)
   Y(i)=floor(dser*U(i));
end
for q=0:dser-1
   for r=0:dser-1
       k(q+1,r+1)=0;
       for j=1:length(Y)/2
          if Y(2*j-1)==q && Y(2*j)==r
             k(q+1,r+1)=k(q+1,r+1)+1;  
          end
       end
   end
end
 Vser=0;
for q=0:dser-1
   for r=0:dser-1
       Vser=Vser+(k(q+1,r+1)-(length(Y)/2)*(1/(dser)^2))^2/((length(Y)/2)*(1/(dser)^2));
   end
end
fprintf('Статистика критерия серий = %10.8f, при %10.0f степенях свободы\n\n\n',Vser,dser^2-1);

% leftser=170.16;
% rightser=220.7;
% aser=130;
% bser=270;
% figure('Name','Serial test')
% probability_density_plot(Vser,leftser,rightser,dser^2-1,aser,bser)






%__________________________Критерий интервалов_____________________________
fprintf('___________________Критерий интервалов_________________________\n\n\n');
j=0;
s=0;
tint=10;
nint=10000;
sch=1;
alf=0;
bet=0.5;
p=bet-alf;


% for r=0:tint-1
%     n1(r+1)=5/((bet-alf)*(1-bet+alf)^r);%Выбор n так, что ожидаемое число интервалов больше 5
% end
% minimN=min(n1);


for r=0:tint
    countint(r+1)=0;
end
while s<nint
   if sch==1
      r=0;
      sch=0;
   end
   j=j+1;
   if U(j)>=alf && U(j)<=bet
      if r>=tint
         countint(tint+1)=countint(tint+1)+1; 
         s=s+1;
         sch=1;
      else
         countint(r+1)=countint(r+1)+1; 
         s=s+1;
         sch=1;
      end
   else
      r=r+1;
   end
end

for r=0:tint
    fprintf('%10.8f  \n\n' , countint(r+1));
end
for r=0:tint-1
   pr(r+1)=p*(1-p)^r; 
end
pr(tint+1)=(1-p)^tint;
Vint=0;
for r=0:tint
    Vint=Vint+((countint(r+1)-nint*pr(r+1))^2)/(nint*pr(r+1));
end
fprintf('Статистика критерия интервалов = %10.8f, при %10.0f степенях свободы\n\n\n',Vint,tint);

% leftint=4.87;
% rightint=15.99;
% aint=0;
% bint=36;
% figure('Name','Gap test')
% probability_density_plot(Vint,leftint,rightint,tint,aint,bint)




%____________________________Покер критерий________________________________
fprintf('___________________Покер критерий_____________________________\n\n\n');
dpok=14;
for i=1:length(U)
   Y(i)=floor(dpok*U(i));
end
npok=fix(lenU/5);
for i=1:7
   poker(i)=0; 
end
for j=1:npok
     s1=Y(5*j-4); s2=Y(5*j-3); s3=Y(5*j-2); s4=Y(5*j-1); s5=Y(5*j); 
     
     bn=0;
     
     if s1~=s2 && s1~=s3 && s1~=s4 && s1~=s5 && s2~=s3 && s2~=s4 && s2~=s5 && s3~=s4 && s3~=s5 && s4~=s5
        poker(7)=poker(7)+1; 
        bn=1;
     end
     
     if sravn5(s1,s2,s3,s4,s5)==5 || sravn5(s1,s3,s2,s4,s5)==5 || sravn5(s1,s4,s2,s3,s5)==5 || sravn5(s1,s5,s2,s3,s4)==5 || sravn5(s2,s3,s1,s4,s5)==5 || sravn5(s2,s4,s1,s3,s5)==5 || sravn5(s2,s5,s1,s3,s4)==5 || sravn5(s3,s4,s1,s2,s5)==5 || sravn5(s3,s5,s1,s2,s4)==5 || sravn5(s4,s5,s1,s2,s3)==5
        poker(5)=poker(5)+1; 
        bn=1;
     end
     
     if sravn3(s1,s2,s3,s4,s5)==3 || sravn3(s1,s2,s4,s3,s5)==3 || sravn3(s1,s2,s5,s3,s4)==3 || sravn3(s1,s3,s4,s2,s5)==3 || sravn3(s1,s3,s5,s2,s4)==3 || sravn3(s1,s4,s5,s2,s3)==3 || sravn3(s2,s3,s4,s1,s5)==3 || sravn3(s2,s3,s5,s1,s4)==3 || sravn3(s2,s4,s5,s1,s3)==3 || sravn3(s3,s4,s5,s1,s2)==3
        poker(3)=poker(3)+1;
        bn=1;
     end
     
     if sravn4(s1,s2,s3,s4,s5)==4 || sravn4(s1,s2,s4,s3,s5)==4 || sravn4(s1,s2,s5,s3,s4)==4 || sravn4(s1,s3,s4,s2,s5)==4 || sravn4(s1,s3,s5,s2,s4)==4 || sravn4(s1,s4,s5,s2,s3)==4 || sravn4(s2,s3,s4,s1,s5)==4 || sravn4(s2,s3,s5,s1,s4)==4 || sravn4(s2,s4,s5,s1,s3)==4 || sravn4(s3,s4,s5,s1,s2)==4
        poker(4)=poker(4)+1;
        bn=1;
     end
     
     if sravn2(s1,s2,s3,s4,s5)==2 || sravn2(s2,s3,s4,s5,s1)==2|| sravn2(s3,s4,s5,s1,s2)==2|| sravn2(s4,s5,s1,s2,s3)==2|| sravn2(s5,s1,s2,s3,s4)==2
        poker(2)=poker(2)+1;
        bn=1;
     end
     
     if s1==s2 && s2==s3 && s3==s4 && s4==s5
        poker(1)=poker(1)+1;
        bn=1;
     end
     
     if sravn6(s1,s2,s3,s4,s5)==6 || sravn6(s1,s3,s2,s4,s5)==6 || sravn6(s1,s4,s2,s3,s5)==6 || sravn6(s1,s5,s2,s3,s4)==6 || sravn6(s2,s3,s1,s4,s5)==6 || sravn6(s2,s4,s1,s3,s5)==6 || sravn6(s2,s5,s1,s3,s4)==6 || sravn6(s3,s4,s1,s2,s5)==6 || sravn6(s3,s5,s1,s2,s4)==6 || sravn6(s4,s5,s1,s2,s3)==6
        poker(6)=poker(6)+1; 
        bn=1;
     end
     
     if bn==0
        fprintf('!!!!!!!!!!!!!!!ОШИБКА покер!!!!!!!!!!!!!!!!!!!!!!!\n\n\n');
     end
end

ppok(7)=((dpok*(dpok-1)*(dpok-2)*(dpok-3)*(dpok-4))/dpok^5);
ppok(6)=((dpok*(dpok-1)*(dpok-2)*(dpok-3))/dpok^5)*10;
ppok(5)=((dpok*(dpok-1)*(dpok-2))/dpok^5)*15;
ppok(4)=((dpok*(dpok-1)*(dpok-2))/dpok^5)*10;    %Вероятности комбинаций
ppok(3)=((dpok*(dpok-1))/dpok^5)*10;
ppok(2)=((dpok*(dpok-1))/dpok^5)*5;
ppok(1)=((dpok)/dpok^5);

sumpok=0;
for i=1:7
    sumpok=sumpok+ppok(i); 
end
if sumpok~=1
    fprintf('!!!!!!!!!!!!!!!ОШИБКА покер!!!!!!!!!!!!!!!!!!!!!!!\n\n\n');
end

Vpok=0;
for i=1:7
    Vpok=Vpok+(poker(i)-npok*ppok(i))^2/(npok*ppok(i));
end
fprintf('Статистика покер критерия = %10.8f, при %10.0f степенях свободы\n\n\n',Vpok,6);


% leftpok=2.2;
% rightpok=10.64;
% apok=0;
% bpok=27;
% figure('Name','Poker test')
% probability_density_plot(Vpok,leftpok,rightpok,6,apok,bpok)


%_____________________Критерий собирания купонов___________________________
fprintf('_____________________Критерий собирания купонов____________________\n\n\n');
dkup=10;
for i=1:length(U)
   Y(i)=floor(dkup*U(i));
end
nkup=20000;
tkup=64;
for r=1:tkup
    countkup(r)=0; 
end
%Y=[];
%Y=[0 1 2 2 3 4 5 6 7 8 9 10 11 12 13 0 1 3 2 4 5 6 7 8 9 10 11 12 13];
j=0;
s=0;

sch=1;
while s<nkup
   if sch==1
    for k=0:dkup-1
        occur(k+1)=0;
    end    
    q=0;
    r=0;
    sch=0;
   end
   j=j+1;
   r=r+1;
   if occur(Y(j)+1)==0
      occur(Y(j)+1)=1;
      q=q+1;
   end
   if q==dkup
      if r>=tkup
         countkup(tkup)=countkup(tkup)+1; 
         s=s+1;
         sch=1;
      else
         countkup(r)=countkup(r)+1;
         s=s+1;
         sch=1;
      end
   end
   
end

countkup
k=tkup-dkup+1;
sumkup=0;
for r=dkup:tkup-1
    pkup(r)=(factorial(dkup)*Stirl(r-1,dkup-1))/(dkup^r);
    sumkup=sumkup+pkup(r);
end
pkup(tkup)=1-(factorial(dkup)*Stirl(tkup-1,dkup))/(dkup^(tkup-1));
sumkup=sumkup+pkup(tkup);
Vkup=0;
for r=dkup:tkup
   Vkup=Vkup+(countkup(r)-nkup*pkup(r))^2/(nkup*pkup(r));
end
fprintf('Статистика критерия собирания купонов = %10.8f, при %10.0f степенях свободы\n\n\n',Vkup,tkup-dkup);


% leftkup=41.18;
% rightkup=67.67;
% akup=10;
% bkup=120;
% figure('Name','Cupon collector test')
% probability_density_plot(Vkup,leftkup,rightkup,tkup-dkup,akup,bkup)


%_______________________Критерий перестановок______________________________
fprintf('_____________________Критерий перестановок_________________________\n\n\n');
tper=3;
nper=300000;
for i=0:factorial(tper)-1
    f(i+1)=0; 
end

for j=1:nper
 W=[U(3*j-2) U(3*j-1) U(3*j)]; 
 r=tper;
 f1=0; 
 while r>1
    for i=1:r
        P(i)=W(i);
    end
    s=find(P==max(P));
    f1=r*f1+s-1;
    qq=W(s);
    W(s)=W(r);
    W(r)=qq;
    r=r-1; 
    P=[];
 end
 f(f1+1)=f(f1+1)+1;
end

Vper=0;
for i=0:factorial(tper)-1
    Vper=Vper+(f(i+1)-nper*(1/factorial(tper)))^2/(nper*(1/factorial(tper)));
end
fprintf('Статистика критерия перестановок = %10.8f, при %10.0f степенях свободы\n\n\n',Vper,factorial(tper)-1);

% leftper=1.61;
% rightper=9.24;
% aper=0;
% bper=24;
% figure('Name','Permutation test')
% probability_density_plot(Vper,leftper,rightper,factorial(tper)-1,aper,bper)

%_______________________Критерий монотонности______________________________
fprintf('_____________________Критерий монотонности_________________________\n\n\n');
nmonot=1000000;
A=[4529.4 9044.9 13568 18091 22615 27892;
   9044.9 18097 27139 36187 45234 55789;
   13568 27139 40721 54281 67852 83685;
   18091 36187 54281 72414 90470 111580;
   22615 45234 67852 90470 113262 139476;
   27892 55789 83685 111580 139476 172860];
B=[1/6 5/24 11/120 19/720 29/5040 1/840];
for r=1:6
    countmonot(r)=0; 
end
q=1;
for i=1:nmonot-1
    if U(i)<=U(i+1)
       q=q+1; 
    else
       if q>5
          countmonot(6)=countmonot(6)+1; 
       else
          countmonot(q)=countmonot(q)+1; 
       end
       q=1;
    end
end
if U(nmonot)>U(nmonot-1)
    countmonot(q)=countmonot(q)+1;
else
    countmonot(1)=countmonot(1)+1; 
end
Vmonot=0;
for i=1:6
    for j=1:6
        Vmonot=Vmonot+(countmonot(i)-nmonot*B(i))*(countmonot(j)-nmonot*B(j))*A(i,j);     
    end
end
countmonot
Vmonot=Vmonot/(nmonot-6);
if nmonot>=4000
   fprintf('Статистика критерия монотонности = %10.8f, при %10.0f степенях свободы\n\n\n',Vmonot,6);
else
   fprintf('Статистика критерия монотонности = %10.8f, при %10.0f степенях свободы\n\n\n',Vmonot,5); 
end

% leftmonot=2.2;
% rightmonot=10.64;
% amonot=0;
% bmonot=27;
% figure('Name','Run test')
% probability_density_plot(Vmonot,leftmonot,rightmonot,6,amonot,bmonot)

%_______________________Критерий максимум-t________________________________
fprintf('_____________________Критерий максимум-t_________________________\n\n\n');
tmaxt=5;
nmaxt=30;

for j=1:nmaxt
    for i=1:tmaxt
        Wmaxt(i)=U(tmaxt*j-(tmaxt-i)); 
    end
    Vmaxt(j)=max(Wmaxt);
end
Knplusmaxt=KScriteria(Vmaxt,tmaxt)
%for i=1:length(Vmaxt)
    %Vmaxt(i)=(Vmaxt(i))^(1/5); 
%end
fprintf('Статистика критерия максимум-t = %10.8f, при n = %10.8f\n\n\n',Knplusmaxt,nmaxt);


%_______________________Критерий конфликтов________________________________
fprintf('_____________________Критерий конфликтов_________________________\n\n\n');
mcon=2^20;
ncon=2^14;%65536
tcon=20;
confl=0;
dcon=2;
for i=1:length(U)
   Ycon(i)=floor(dcon*U(i));
end
for j=0:ncon-1
    Vcon(j+1)=string(Ycon(20*j+1));
    for i=1:tcon-1
        sbl=string(Ycon(20*j+i+1));
        if sbl==string(2)
           sbl=1; 
        end
        Vcon(j+1)=Vcon(j+1)+sbl; 
    end
end
for j=1:mcon
    Urn(j)=0; 
end
for j=0:ncon-1
    if Urn(bin2dec(Vcon(j+1))+1)==1
        confl=confl+1;
    elseif Urn(bin2dec(Vcon(j+1))+1)==0
        Urn(bin2dec(Vcon(j+1))+1)=1;
    end
end
fprintf('Количество конфликтов = %10.8f\n\n\n',confl);



%_____________Критерий промежутков между днями рождений____________________
fprintf('_____________________Критерий промежутков между днями рождений_________________________\n\n\n');
ndr=512;
mdr=2^25;
ddr=mdr;
Rdr=0;
for i=1:length(U)
   Ydr1(i)=floor(ddr*U(i));
end
for i=1:ndr
   Ydr(i)=Ydr1(i);
end
Ydr=sort(Ydr);
for i=1:ndr-1
    Sdr(i)=Ydr(i+1)-Ydr(i); 
end
Sdr(ndr)=Ydr(1)+mdr-Ydr(ndr);
for j=2:ndr
    if Sdr(j)==Sdr(j-1)
        Rdr=Rdr+1;
    end 
end
fprintf('Количество равных промежутков = %10.8f\n\n\n',Rdr);


%_________________Критерий сериальной корреляции___________________________
fprintf('_____________________Критерий сериальной корреляции_________________________\n\n\n');
nsc=lenU;
Asc=0;
Bsc=0;
Dsc=0;
for i=1:nsc-1
    Asc=Asc+U(i)*U(i+1);
end
Asc=Asc+U(nsc)*U(1);
for i=1:nsc
    Bsc=Bsc+U(i);
end
Bsc=Bsc^2;
for i=1:nsc
    Dsc=Dsc+U(i)^2;
end
musc=-1/(nsc-1);
sigmvkvsc=(nsc^2)/((nsc-1)^2*(nsc-2));
musc-2*sqrt(sigmvkvsc);
Csc=(nsc*Asc-Bsc)/(nsc*Dsc-Bsc);
musc+2*sqrt(sigmvkvsc);
Csc
if (musc-2*sqrt(sigmvkvsc))<=Csc && Csc<=(musc+2*sqrt(sigmvkvsc))
    fprintf('Удовлетворяет критерию\n')
    resultsc='+';
else
    fprintf('Не удовлетворяет критерию\n') 
    resultsc='-';
end


z1=0;
z2=Vser;
z3=Vint;
z4=Vpok;
z5=Vkup;
z6=Vper;
z7=Vmonot;
z8=Knplusmaxt;
z9=confl;
z10=Rdr;
z11=Csc;
v1=0;
v2=dser^2-1;
v3=tint;
v4=6;
v5=tkup-dkup;
v6=factorial(tper)-1;
v7=6;
v8=nmaxt;
v9=0;
v10=0;
v11=0;













