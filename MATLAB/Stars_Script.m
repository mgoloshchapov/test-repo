%% Изучение красного смещения звезд

close all
clear variables
% *Импорт данных*

spectra = importdata('spectra.csv')
starNames = importdata('star_names.csv')
lambdaStart = importdata('lambda_start.csv')
lambdaDelta = importdata('lambda_delta.csv')
% Определение диапазона длин волн

nObs = size(spectra, 1)  % number(n) of observations
nSt = size(starNames, 1)  % n of stars

lambdaEnd = lambdaStart + (nObs-1) * lambdaDelta 
lambda = (lambdaStart : lambdaDelta : lambdaEnd)'
% *Константы*

lambdaPr = 656.28; %nanomet
speedOfLight = 299792.458; %km/s
% *Расчет скорости удаления звезд от Земли*

[sHa, idx] = min(spectra)
lambdaHa = lambda(idx)

z = (lambdaHa / lambdaPr) - 1
speed = z * speedOfLight
movaway = starNames(speed > 0)
% *График*

fig = figure

plt = plot(lambda, spectra, '--', 'LineWidth', 1)

for i = 1 : 1 : nSt
    if speed(i) > 0
        plt(i).LineWidth = 3
        plt(i).LineStyle = '-'
    end
end

set(fig, 'Visible', 'on')

xlabel('Длина волны, нм')
ylabel(['Интенсивность эрг/см^2/с/', char(197)])
title('Спектры звёзд')
legend(starNames, 'Location', 'Northeast')
grid on
% Сохранить график

saveas(fig, 'spectraAll')
%% 
%