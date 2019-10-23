%Matrícula 2017009023
clear all
close all
clc

%{solução 1
dataset = xlsread('reposta no tempo.xlsx', 'Main.inputX(t)', 'A4:B256');
dataset1 = xlsread('resposta em frequencia.xlsx','Main.GX,X(f)', 'A4:B110');
z = dataset (:,1);
zz = dataset (:,2);
t=[0:0.0001:0.6800];
prompt = {'M_{motor} (Kg)','M_{pedestal} (Kg)', 'M_{parafuso} (Kg)', 'H (m)','D_{i} (m)','D_{e} (m)','e (m)','\zeta','\omega_{exc} 1 (Hz)', '\omega_{exc} 2 (Hz)', '\omega_{n} (rad/s)', 'Número de parafusos'};
opts.Interpreter = 'tex';
opts.Resize='on';
opts.WindowStyle='modal';
definput = {'10.67', '6.29','12.2*10^-3', '0.868', '0.0809', '0.0877', '82*10^-3', '0.008658', '58.7', '117.4', '20', '2'};
X = inputdlg(prompt, 'Dados',[1 50],definput, opts);
y = cellfun(@str2num, X);
mm = y(1); mp = y(2); mpa = y(3); h = y(4); di = y(5); de = y(6); e = y(7); zeta = y(8); freq = y(9)*2*pi(); freq2 = y(10)*2*pi(); wn = y(11); n = y(12);
meq = mm + 0.23*mp + mpa*n;
r=freq/wn;
x = 2*mpa*e/meq*r^2/sqrt((1-r^2)^2+(2*zeta*r)^2);
r2 = 2*r;
teta = atan(2*zeta*r/(1-r^2));
teta2 = atan(2*zeta*r2/(1-r2^2));
func = +freq^2*x*sin(freq*t+teta)-38.9356*sin(freq2*t+teta2);
plot(t,func, '--')
hold on

%{solução 2
plot(z,zz)
acel = -24.3494*0*sin(368.823*t) - 88.148*sin(737.646*t);
%plot (t, acel, '.--')
title('Resposta no tempo')
xlabel('Tempo (s)')
ylabel('Aceleração (m/s^2)')
legend('Resposta analítica', 'Dados do experimento')
hold off
%}
