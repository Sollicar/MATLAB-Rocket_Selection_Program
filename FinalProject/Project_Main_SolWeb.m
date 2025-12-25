% ------------------------------------------------------------------------
%   Name: Carson Sollis
%
%   File Description: [This main file will take the input of the user and save them all to variables and then it will get a cell and matrix back from the function and
% it will then tell the user which rockets they can use. the other function will also generated 3 graphs giving visual representation of the rockets cost per pound of payload, realability, 
% and total launches. The user will then select a rocket and it will give them the data abouit that rocket in the form of a fprintf]
%
 
clear % useful to clear your workspace and use new variables
clc %always clear screens before youu start
close all % (optional) needed to close any opned graph or figures
commandwindow % make the commend mindow the active location
% -------------------------------------------------------------------------

% Introduction:

fprintf('Hello welcome to our Rocket Selection Program!\n')

orbit = input('\nWhat is the desired orbit? (LEO, GEO, Lunar, Mars): ', 's');
validOrbits = ["LEO", "GEO", "Lunar", "Mars"];
while isempty(orbit) || ~any(strcmpi(orbit, validOrbits))
     fprintf('\nError must 1 of 4 orbits: (LEO, GEO, Lunar, Mars) \n')
     orbit = input('\nWhat is the desired orbit? (LEO, GEO, Lunar, Mars): ', 's');
end
if strcmpi(orbit, "LEO") %<SM:IF:Sollis>
payload= input('\nPlease input payload weight in lbs (Between 0 and 290,000): ');
while isempty(payload) || payload <= 0 || payload > 290000  
    fprintf('\nError must input a positive number not bigger than 290,000 \n')
    payload= input('\nPlease input payload weight in lbs (Between 0 and 290,000): ');
end
else
payload= input('\nPlease input payload weight in lbs (Between 0 and 59,500): ');
while isempty(payload) || payload <= 0 || payload > 59500 
    fprintf('\nError must input a positive number not bigger than 59,500 \n')
    payload= input('\nPlease input payload weight in lbs (Between 0 and 59,500): ');
end
end

payDia = input('\nWhat is the diameter of your payload? (Between 0 and 27.6 ft): ');
while isempty(payDia) || payDia <= 0 ||payDia > 27.6 
    fprintf('\nError must input a number between 0 and 27.6 \n')
    payDia = input('\nWhat is the diameter of your payload? (Between 0 and 27.6 ft): ');
end

payHeight = input('\nWhat is the height of your payload? (Between 0 and 90 ft): ');
while isempty(payHeight) || payHeight <= 0 || payHeight > 90 
    fprintf('\nError must input a number between 0 and 90 \n')
    payHeight = input('\nWhat is the height of your payload? (Between 0 and 90 ft): ');
end

fuelType = input('\nWhat type of fuel would you like? (Methalox, Hydrolox, Kerolox, Nopref): ', 's');
validFuel = ["Methalox","Hydrolox","Kerolox","Nopref"];
while isempty(fuelType) || ~any(strcmpi(fuelType, validFuel)) 
     fprintf('\nError must 1 of 4 Fuels: (Methalox, Hydrolox, Kerolox, Nopref) \n')
     fuelType = input('What type of fuel would you like? (Methalox, Hydrolox, Kerolox, Nopref): ', 's');
end
%%
[avaRockets, avaRocketsMat] = Project_AccRockets_SolWeb(payload, payDia, payHeight, orbit, fuelType); %<SM:PDF:Sollis>
Project_costCal_SolWeb(payload, avaRocketsMat, avaRockets, orbit); 

if size(avaRockets,1) == 2 
    rocketChoice = avaRockets(2,:);
    rocketChoiceMat = avaRocketsMat(1,:);
    fprintf('\nOnly one rocket will work for you, selecting it.\n')
else
    rocketChoice = [];
    rocketChoiceMat = [];
    
    while isempty(rocketChoice)
        choice = input('Out of these rockets which would you like to chose (Name of rocket)? ', 's');
        
        for i = 2:size(avaRockets,1)
            if strcmpi(choice, avaRockets{i,1})
                rocketChoice = avaRockets(i,:);
                rocketChoiceMat = avaRocketsMat(i-1,:);
            end
        end
        
        if isempty(rocketChoice)
            fprintf('Error... Rocket %s is not found. Please try again.\n', choice);
        end
    end
end
%%
name = rocketChoice{1,1};
if strcmp(rocketChoice{1,14}, "KenVan")
    location = 'Kennedy Space Port or Vandenburg Space Port';
elseif strcmp(rocketChoice{1,14}, "Ken")
    location = 'Kennedy Space Port';
elseif strcmp(rocketChoice{1,14}, "FG")
    location = 'French Guiana';
elseif strcmp(rocketChoice{1,14}, "Kaz")
    location = 'Kazakhstan';
elseif strcmp(rocketChoice{1,14}, "WalNZ") 
    location = 'New Zealand';
end
if strcmpi(orbit, "LEO")
    price = rocketChoiceMat(1,5) / payload;
else
    price = rocketChoiceMat(1,6) / payload;
end
fuel = rocketChoice{1,13};

fprintf(['Great! You have chosen %s rocket.\n' ...
    ' This rocket will be taking you to %s and at the price of $%0.2f per pound of payload.\n' ...
    'It will be launched from %s, using %s \n'],name, orbit, price, location,fuel)
%%
%{
Add a sample run here (include input validations): 
Hello welcome to our Rocket Selection Program!

What is the desired orbit? (LEO, GEO, Lunar, Mars): 7

Error must 1 of 4 orbits: (LEO, GEO, Lunar, Mars) 

What is the desired orbit? (LEO, GEO, Lunar, Mars): GEO

Please input payload weight in lbs (Between 0 and 59,500): 650000

Error must input a positive number not bigger than 59,500 

Please input payload weight in lbs (Between 0 and 59,500): 15000

What is the diameter of your payload? (Between 0 and 27.6 ft): 30

Error must input a number between 0 and 27.6 

What is the diameter of your payload? (Between 0 and 27.6 ft): 8

What is the height of your payload? (Between 0 and 90 ft): 100

Error must input a number between 0 and 90 

What is the height of your payload? (Between 0 and 90 ft): 8

What type of fuel would you like? (Methalox, Hydrolox, Kerolox, Nopref): you

Error must 1 of 4 Fuels: (Methalox, Hydrolox, Kerolox, Nopref) 
What type of fuel would you like? (Methalox, Hydrolox, Kerolox, Nopref): Nopref
((Graphs will be produced here))
     Name of Rocket     Payload Cap (LEO) (Pounds)    Payload Cap (GEO) (Pounds)    PayDia    Payheight    Cost of launch (LEO)    Cost Of launch (GEO)    Launches    Success    Reliability (Success Launch/launches)    Lunar orbits?    Mars orbit     Fuel Types     Launch Pads
    ________________    __________________________    __________________________    ______    _________    ____________________    ____________________    ________    _______    _____________________________________    _____________    __________    ____________    ___________

    {'Falcon 9'    }                 50265                      18300                17.1       17.1            6.985e+07               6.985e+07            568         555                      97.71                        {'Y'}          {'Y'}       {'Kerolox' }    {'KenVan'} 
    {'Falcon Heavy'}            1.4066e+05                      58900                17.1       17.1              9.7e+07                 9.7e+07             11          11                        100                        {'Y'}          {'Y'}       {'Kerolox' }    {'Ken'   } 
    {'Ariane VI'   }                 47730                      25350                  18         18              8.8e+07                1.06e+08              4           4                        100                        {'Y'}          {'Y'}       {'Hydrolox'}    {'FG'    } 
    {'SLS'         }               2.9e+05                      59500                27.6         90                2e+09                   3e+09              1           1                        100                        {'Y'}          {'Y'}       {'Hydrolox'}    {'Ken'   } 
    {'New Glenn'   }                 99000                      30000                  23         72                7e+07                 1.1e+08              1           1                        100                        {'Y'}          {'Y'}       {'Methalox'}    {'Ken'   } 

Out of these rockets which would you like to chose (Name of rocket)? Yelp
Error... Rocket Yelp is not found. Please try again.
Out of these rockets which would you like to chose (Name of rocket)? Falcon 9
Great! You have chosen Falcon 9 rocket.
 This rocket will be taking you to GEO and at the price of $4656.67 per pound of payload.
It will be launched from Kennedy Space Port or Vandenburg Space Port, using Kerolox 




Hello welcome to our Rocket Selection Program!

What is the desired orbit? (LEO, GEO, Lunar, Mars): -9

Error must 1 of 4 orbits: (LEO, GEO, Lunar, Mars) 

What is the desired orbit? (LEO, GEO, Lunar, Mars): LEO

Please input payload weight in lbs (Between 0 and 290,000): -1000

Error must input a positive number not bigger than 290,000 

Please input payload weight in lbs (Between 0 and 290,000): 700

What is the diameter of your payload? (Between 0 and 27.6 ft): -8

Error must input a number between 0 and 27.6 

What is the diameter of your payload? (Between 0 and 27.6 ft): 8

What is the height of your payload? (Between 0 and 90 ft): -9

Error must input a number between 0 and 90 

What is the height of your payload? (Between 0 and 90 ft): 8

What type of fuel would you like? (Methalox, Hydrolox, Kerolox, Nopref): 7

Error must 1 of 4 Fuels: (Methalox, Hydrolox, Kerolox, Nopref) 
What type of fuel would you like? (Methalox, Hydrolox, Kerolox, Nopref): nopref
      Name of Rocket      Payload Cap (LEO) (Pounds)    Payload Cap (GEO) (Pounds)    PayDia    Payheight    Cost of launch (LEO)    Cost Of launch (GEO)    Launches    Success    Reliability (Success Launch/launches)    Lunar orbits?    Mars orbit     Fuel Types     Launch Pads
    __________________    __________________________    __________________________    ______    _________    ____________________    ____________________    ________    _______    _____________________________________    _____________    __________    ____________    ___________

    {'Falcon 9'      }                 50265                      18300                17.1       17.1            6.985e+07               6.985e+07             568        555                      97.71                        {'Y'}          {'Y'}       {'Kerolox' }    {'KenVan'} 
    {'Falcon Heavy'  }            1.4066e+05                      58900                17.1       17.1              9.7e+07                 9.7e+07              11         11                        100                        {'Y'}          {'Y'}       {'Kerolox' }    {'Ken'   } 
    {'Electron'      }                   710                          0                 8.2        8.2              7.5e+06                       0              74         70                      94.59                        {'N'}          {'N'}       {'Kerolox' }    {'WalNZ' } 
    {'Ariane VI'     }                 47730                      25350                  18         18              8.8e+07                1.06e+08               4          4                        100                        {'Y'}          {'Y'}       {'Hydrolox'}    {'FG'    } 
    {'Soyuz'         }                 19000                       3000                13.5       37.4              5.3e+07                2.25e+08            1700       1680                      98.82                        {'Y'}          {'Y'}       {'Kerolox' }    {'Kaz'   } 
    {'SLS'           }               2.9e+05                      59500                27.6         90                2e+09                   3e+09               1          1                        100                        {'Y'}          {'Y'}       {'Hydrolox'}    {'Ken'   } 
    {'New Glenn'     }                 99000                      30000                  23         72                7e+07                 1.1e+08               1          1                        100                        {'Y'}          {'Y'}       {'Methalox'}    {'Ken'   } 
    {'Vulcan Centaur'}                 60000                      14300                17.7         70              6.6e+08                 1.2e+09               3          3                        100                        {'Y'}          {'Y'}       {'Methalox'}    {'Ken'   } 
    {'Atlas V'       }                 41570                       8500                  18         87             1.53e+08                1.53e+08             104        104                        100                        {'Y'}          {'Y'}       {'Kerolox' }    {'KenVan'} 

Out of these rockets which would you like to chose (Name of rocket)? you
Error... Rocket you is not found. Please try again.
Out of these rockets which would you like to chose (Name of rocket)? Electron
Great! You have chosen Electron rocket.
 This rocket will be taking you to LEO and at the price of $10714.29 per pound of payload.
It will be launched from New Zealand, using Kerolox 

%}