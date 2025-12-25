function [avaRockets, avaRocketsMat]= Project_AccRockets_SolWeb(payload,payDia,payHeight,orbit,fuelType)

avaRocketsMat=[];
rockets = readcell("115Project.xlsx"); 
titles = rockets(1,:);
avaRockets = titles;
temp = rockets(2:10, 2:10);
allRockets = str2double(string(temp));
fuelMatrix = string(rockets(2:10,13));

if strcmpi(orbit, "LEO")
    payloadVector = allRockets(:,1);
    for k = 1:size(allRockets,1) 
        fuelOk = strcmpi(fuelType,"Nopref") || strcmpi(fuelType,fuelMatrix(k));
        if payload <= payloadVector(k) && payDia <= allRockets(k,3) && payHeight <= allRockets(k,4) && fuelOk %<SM:FILTER:Sollis>
            avaRockets = [avaRockets; rockets(k+1,:)];
            avaRocketsMat = [avaRocketsMat;allRockets(k,:)]; 
        end
    end
else
    payloadVector = allRockets(:,2);
    for k = 1:size(allRockets,1)
        fuelOk = strcmpi(fuelType,"Nopref") || strcmpi(fuelType,fuelMatrix(k));
        if payload <= payloadVector(k) && payDia <= allRockets(k,3) && payHeight <= allRockets(k,4) && fuelOk
            avaRockets = [avaRockets; rockets(k+1,:)];
            avaRocketsMat = [avaRocketsMat;allRockets(k,:)];
        end
    end
end

if size(avaRockets,1) == 1
    fprintf('Error... No rockets meet your requirements.');
else
    if size(avaRockets,1) > 2
        if strcmpi(orbit, "LEO")
            [sortedNum, sortOrd] = sort(avaRocketsMat(:,1)); 
        else
            [sortedNum, sortOrd] = sort(avaRocketsMat(:,2));
        end

        avaRocketsMat = avaRocketsMat(sortOrd, :);
        avaRockets(2:end,:) = avaRockets(1 + sortOrd, :);
    end
    avaRocketsTable = cell2table(avaRockets(2:end,:), 'VariableNames', avaRockets(1,:));
    disp(avaRocketsTable)
end

end