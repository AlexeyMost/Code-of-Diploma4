format long
% [y,Fs] = audioread('diplom5.m4a');
% %[y,Fs] = audioread('white_noise.wav');
% %for i=1:240000
%    %y1(i)=y(i); 
% %end
% %y=[];
% %y=y1;
% %y1=[];
% sum=0;
% maxim=max(y)
% minim=min(y)
% for i=1:length(y)
%    y(i)=y(i)-minim; 
% end
% maxim=max(y)
% minim=min(y)
% k=1/maxim
% for i=1:length(y)
%    y(i)=y(i)*k;
% end
% for i=1:length(y)
%    sum=sum+y(i); 
% end
% maxim=max(y)
% minim=min(y)
% m=sum/length(y);
% sum=0;
% for i=1:length(y)
%    sum=sum+(y(i)-m)^2; 
% end
% D=sum/(length(y)-1);

% for i=1:length(y)
%     y(i)=(y(i)-m)/sqrt(D); 
% end
%y;
%h=kstest(y)
%hist(y,100)

%for i=1:length(y)
   %Unoise(i)=F(y(i),m,D);
%end


 
 %for i=11000:length(Unoise)
     %Unoise11000(i-10999)=Unoise(i); 
 %end
U=rand(1,1000000);
% figure(2)
% hist(U,100)
%load('gog.mat');
gog=xlsread('RanNumEx.xlsx');
%Uwnoise=y;
for i=1:1000
    for j=1:1000
      Uxl(j+(i-1)*1000)=gog(i,j);  
    end
end
% U=Uxl;

% for i=1:length(U)
%    sum=sum+U(i); 
% end
% maxim=max(U);
% minim=min(U);
% m=sum/length(U)
% sum=0;
% for i=1:length(U)
%    sum=sum+(U(i)-m)^2; 
% end
% D=sum/(length(U)-1)

%KnutTests(Unoise,length(Unoise))
%KnutTests(Unoise,length(Unoise11000))
[z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,resultscm]=KnutTests(U,length(U))
[w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,resultsce]=KnutTests(Uxl,length(Uxl))
%KnutTests(Uwnoise,length(Uwnoise))
%__________________________ГРАФИКИ__________________________________________________-
leftser=170.16;
rightser=220.7;
aser=130;
bser=270;
titl1='Критерий серий';
figure('Name','Serial test')
%title('Критерий серий')
%subtitle(['\nu=',num2str(v2)])
%[t,s]=title('Критерий серий',['\nu=',num2str(v2)])
probability_density_plot_for_comparison(z2,w2,leftser,rightser,v2,aser,bser,titl1)

leftint=4.87;
rightint=15.99;
aint=0;
bint=36;
titl2='Критерий интервалов';
figure('Name','Gap test')
probability_density_plot_for_comparison(z3,w3,leftint,rightint,v3,aint,bint,titl2)

leftpok=2.2;
rightpok=10.64;
apok=0;
bpok=27;
titl3='Покер-критерий';
figure('Name','Poker test')
probability_density_plot_for_comparison(z4,w4,leftpok,rightpok,v4,apok,bpok,titl3)

leftkup=41.18;
rightkup=67.67;
akup=10;
bkup=120;
titl4='Критерий собирания купонов';
figure('Name','Cupon collector test')
probability_density_plot_for_comparison(z5,w5,leftkup,rightkup,v5,akup,bkup,titl4)

leftper=1.61;
rightper=9.24;
aper=0;
bper=24;
titl5='Критерий перестановок';
figure('Name','Permutation test')
probability_density_plot_for_comparison(z6,w6,leftper,rightper,v6,aper,bper,titl5)

leftmonot=2.2;
rightmonot=10.64;
amonot=0;
bmonot=27;
titl6='Критерий монотонности';
figure('Name','Run test')
probability_density_plot_for_comparison(z7,w7,leftmonot,rightmonot,v7,amonot,bmonot,titl6)

if (z2>leftser) && (z2<rightser)
    resultserm='+';
else
    resultserm='-';
end

if (w2>leftser) && (w2<rightser)
    resultsere='+';
else
    resultsere='-';
end

if (z3>leftint) && (z3<rightint)
    resultintm='+';
else
    resultintm='-';
end

if (w3>leftint) && (w3<rightint)
    resultinte='+';
else
    resultinte='-';
end

if (z4>leftpok) && (z4<rightpok)
    resultpokm='+';
else
    resultpokm='-';
end

if (w4>leftpok) && (w4<rightpok)
    resultpoke='+';
else
    resultpoke='-';
end

if (z5>leftkup) && (z5<rightkup)
    resultkupm='+';
else
    resultkupm='-';
end

if (w5>leftkup) && (w5<rightkup)
    resultkupe='+';
else
    resultkupe='-';
end

if (z6>leftper) && (z6<rightper)
    resultperm='+';
else
    resultperm='-';
end

if (w6>leftper) && (w6<rightper)
    resultpere='+';
else
    resultpere='-';
end

if (z7>leftmonot) && (z7<rightmonot)
    resultmonotm='+';
else
    resultmonotm='-';
end

if (w7>leftmonot) && (w7<rightmonot)
    resultmonote='+';
else
    resultmonote='-';
end

%__________________________ТАБЛИЦА_________________________________________________
fprintf('|Критерий         |Степень свободы|Matlab    |Excel     |Левое крит. знач.|Правое крит. знач.|Рез. MATLAB|Рез. Excel\n')
fprintf('|_________________|_______________|__________|__________|_________________|__________________|___________|__________\n')
fprintf('|Серий            |%-3.0f            |%-5.2f    |%-5.2f    |%-5.2f           |%-5.2f            |%s          |%s\n',v2,z2,w2,leftser,rightser,resultserm,resultsere)
fprintf('|Интервалов       |%-3.0f            |%-5.2f     |%-5.2f     |%-5.2f            |%-5.2f             |%s          |%s\n',v3,z3,w3,leftint,rightint,resultintm,resultinte)
fprintf('|Покер            |%-3.0f            |%-5.2f     |%-5.2f     |%-5.2f            |%-5.2f             |%s          |%s\n',v4,z4,w4,leftpok,rightpok,resultpokm,resultpoke)
fprintf('|Собирания Купонов|%-3.0f            |%-5.2f     |%-5.2f     |%-5.2f            |%-5.2f             |%s          |%s\n',v5,z5,w5,leftkup,rightkup,resultkupm,resultkupe)
fprintf('|Перестановок     |%-3.0f            |%-5.2f     |%-5.2f     |%-5.2f            |%-5.2f             |%s          |%s\n',v6,z6,w6,leftper,rightper,resultperm,resultpere)
fprintf('|Монотонности     |%-3.0f            |%-5.2f     |%-5.2f     |%-5.2f            |%-5.2f             |%s          |%s\n',v7,z7,w7,leftmonot,rightmonot,resultmonotm,resultmonote)
fprintf('|Сериальной корр. |       -       |%+5.5f  |%+5.5f  |       -         |       -          |%s          |%s\n',z11,w11,resultscm,resultsce)







% fprintf('|Критерий         |Степень свободы/кол-во набл.|Matlab    |Excel     |Левое крит. знач.|Правое крит. знач.|\n')
% %fprintf('|Равномерности    |                            |          |          |\n')
% fprintf('|Серий            |%3f                  |%5.5f |%5.5f |%5.2f|%5.2f\n',v2,z2,w2,leftser,rightser)
% fprintf('|Интервалов       |%3f                   |%5.5f  |%5.5f   |\n',v3,z3,w3)
% fprintf('|Покер            |%3f                    |%5.5f   |%5.5f   |\n',v4,z4,w4)
% fprintf('|Собирания Купонов|%3f                   |%5.5f  |%5.5f  |\n',v5,z5,w5)
% fprintf('|Перестановок     |%3f                    |%5.5f   |%5.5f   |\n',v6,z6,w6)
% fprintf('|Монотонности     |%3f                    |%5.5f   |%5.5f   |\n',v7,z7,w7)
% %fprintf('|Максимум-t       |%3f                   |%5.5f   |%5.5f   |\n',v8,z8,w8)
% %fprintf('|Конфликтов       |%3f                    |%5.5f |%5.5f |\n',v9,z9,w9)
% %fprintf('|Дни Рождения     |%3f                    |%5.5f   |%5.5f   |\n',v10,z10,w10)
% fprintf('|Сериальной корр. |%3f                    |%5.5f   |%5.5f   |\n',v11,z11,w11)


