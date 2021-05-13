function z=probability_density_plot_for_comparison(V1,V2,left,right,degree_of_freedom,a,b,titl)

x=a:0.01:b;
for i=1:length(x)
    y(i)=chi2pdf(x(i),degree_of_freedom);
end

x1=a:0.01:left;
for i=1:length(x1)
    y1(i)=chi2pdf(x1(i),degree_of_freedom);
end

x2=right:0.01:b;
for i=1:length(x2)
    y2(i)=chi2pdf(x2(i),degree_of_freedom);
end
grid on
plot(x,y,'r')
hold on
area(x1,y1,'FaceColor','c')
hold on
area(x2,y2,'FaceColor','y')
hold on
%plot(189.52099,0,'k-x')
plot(V1,0,'kx')
hold on
plot(V2,0,'m*')
grid on
legend('Плотность вероятности','Левая критическая область','Правая критическая область','статистика MATLAB','статистика Excel')
xlabel('Статистика теста')
ylabel('Плотность вероятности \chi^2 распределения')
title([titl,', \nu=',num2str(degree_of_freedom)]);
%[t,s] = title(titl,['\nu=',num2str(degree_of_freedom)]);
%subtitle(['\nu=',num2str(degree_of_freedom)])
%suptitle(['\nu=',degree_of_freedom])



