%This script reads the adjusted prices on the csv; 
%plots the autocorrelation of simple returns, compound returns, simple squared returns and compound squared returns 
%and computes the Ljung-Box Q-Test for each of them.

clear
m = csvread('prices5y.csv', 1, 5, [1 5 1258 5])';   %take prices from csv
for i=2:(length(m))
    simplereturn(i-1) = (m(i)-m(i-1))/m(i-1);    %simple return definition
    compundreturn(i-1) = log((m(i)/m(i-1)));     %compound return def
end

%plot autocorrelazion value with function autocorr
figure   
subplot(2,2,1);
autocorr( simplereturn )
title('simple returns')

subplot(2,2,2);
autocorr( compundreturn )
title('compound returns')

subplot(2,2,3);
autocorr( (simplereturn-mean(simplereturn)).^2 )
title('squared simple returns')

subplot(2,2,4);
autocorr( (compundreturn-mean(compundreturn)).^2 )
title('squared compound returns')

% Now we are doing the Ljung-Box Q-Test for autocorrelation
% (Null hypothesys H0 := no autocorrelation)
% h is the rejection decision (=0 no enough evidence to reject H0)
% pValue is the p-value for the hypothesis test 
[h1,pValue1] = lbqtest( simplereturn, 'lags', 21 )
[h2,pValue2] = lbqtest( compundreturn, 'lags', 21 )
[h3,pValue3] = lbqtest( simplereturn-mean(simplereturn).^2, 'lags', 21 )
[h4,pValue4] = lbqtest( compundreturn-mean(compundreturn).^2, 'lags', 21 )




