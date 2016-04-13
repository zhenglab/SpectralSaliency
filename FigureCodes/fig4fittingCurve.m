load sigma-length.mat
x=1:1:500;
y=optimal_sigma;
z=467*x.^(-1);
plot(1:500,y,'b','LineWidth',2);
set(gca,'XTickLabel',str2num(get(gca,'XTickLabel'))./1000);
xlabel('l/L');
ylabel('\sigma');
title('');
hold on
plot(1:500,z,'r','LineWidth',2);
legend('Relation curve','Fitting curve')

print('-depsc','-r1000','curvefitting');