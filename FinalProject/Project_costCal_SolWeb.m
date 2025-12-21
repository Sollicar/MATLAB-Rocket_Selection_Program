function Project_costCal_SolWeb(payload, avaRocketsMat, avaRockets, orbit)

%<SM:PDF_PARAM:Webster>          %<SM:PDF_RETURN:Webster>

if strcmpi(orbit, "LEO")
    costVector = avaRocketsMat(:,5) ./ payload; %<SM:SLICE:Webster>
else
    costVector = avaRocketsMat(:,6) ./ payload; %<SM:ANALYZE:Webster>
end

numRockets = size(avaRocketsMat,1);
if numRockets > 1
    rocketNames = avaRockets(2:end,1); %<SM:REF:Webster>
else
    rocketNames = avaRockets(2,1);
end
%%
subplot(3,1,1);
if numRockets == 1
    bar(costVector, 'b');
else
    plot(costVector,'LineWidth',3, 'Color', 'Blue', 'Marker','o'); %<SM:PLOT:Sollis>
end
ylabel('Cost per Pound ($)');
title('Launch Cost per Rocket');
xticks(1:numRockets); 
xticklabels(rocketNames);
grid on;

%%
reliability = avaRocketsMat(:,9);
subplot(3,1,2);
if numRockets == 1
    bar(reliability, 'G'); %<SM:PLOT:Webster>
else
    plot(reliability,'LineWidth',3);
end
ylabel('% Successful');
ylim([95 100]);
title('Reliability of Rockets (Success/Launch total)');
xticks(1:numRockets); %<SM:BUILT-FUNC:Webster>
xticklabels(rocketNames);
grid on;

%%
launches = avaRocketsMat(:,7);
subplot(3,1,3);
if numRockets == 1
    bar(launches, 'R');
else
    plot(launches,'LineWidth',2, 'Color', 'Red', 'Marker','x');
end
ylabel('# of Launches');
title('# of Launches of each rocket');
xticks(1:numRockets);
xticklabels(rocketNames);
grid on;
%%
rocketGraphData = table(rocketNames, costVector, reliability, launches, 'VariableNames', {'Rocket','CostPerPound','Reliability','Launches'});
writetable(rocketGraphData, 'RocketGraphData.csv'); %<SM:WRITE:Webster>
