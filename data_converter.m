%data_converter: script to convert csv formatted TMY data to mat formatted
%matlab data
%
%Description:the script will generate three files city_name.mat,file_name.mat
%and country_code.mat, written to the folder Auxiliary data. Then the 
%script will generate mat formatted weather data written to folder Weather 
%data. Old files in these two folders will be overwritten.
%
% To use generated data for the main program, copy folder Weather data and 
%Auxiliary data to the main directory.
%
% Warning: this script may take very long time!
%%% -----  Programmcode ----- %%%
%% purge cache 
clear all
close all

%% load data
inlist = dir('./input/');
a = length(inlist);

city_name = cell(a-2,1);
file_name = cell(a-2,1);

m = 1;
for i = 1:1:a-2
    file_str = char(inlist(i+2).name);
    country_code{i,1} = file_str(1:3);
    k = strfind(file_str, '.');
    [c d] = size(k);
    if d>1
        file_str = file_str(5:k(d-1)-1);
    else
        file_str = file_str(5:k-1);
    end
    k = strfind(file_str, '.');
    file_str(k) = ' ';
    k = strfind(file_str, '_');
    file_str(k) = ' ';
    city_name_2{i} = file_str;
    if i>1
        if strcmp(city_name_2{i-1},file_str)==1
            m = m+1;
            city_name{i} = [file_str ' ' num2str(m)];
            file_str = [country_code{i} ' ' city_name{i} '.' 'mat'];
            file_name{i} = file_str;
        else
            m = 1;
            city_name{i} = file_str;
            file_str = [country_code{i} ' ' city_name{i} '.' 'mat'];
            file_name{i} = file_str;
        end
    else
        city_name{i} = file_str;
        file_str = [country_code{i} ' ' city_name{i} '.' 'mat'];
        file_name{i} = file_str;
    end
end
save('./auxiliary/city_name.mat','city_name');
save('./auxiliary/file_name.mat','file_name');
save('./auxiliary/country_code.mat','country_code');

for i = 1:1:a-2
    % filenames
    filein_str = ['./input/' char(inlist(i+2).name)];
    fileout_str = ['./output/' file_name{i}];
    if exist(fileout_str,'file')==2 % if already exists
        continue;
    end
    % input weather data
    [location.latitude, location.longitude, time.UTC, location.altitude] = importfile_EPW_location(filein_str,1, 1);
    [the_year, the_month, the_day, the_hour] = importfile_EPW_time(filein_str,9, 8768);
    [GHI,DNI,DHI] = importfile_EPW_solar(filein_str,9, 8768);
    % extraterristrial normal radiation 
    EHR = 1367*(1+0.0334*cos(2*pi*day(datetime(the_year,the_month,the_day),'dayofyear')/365.25));
    % solar position
    T = datetime(the_year, the_month, the_day, the_hour, zeros(size(the_year)), zeros(size(the_year)));
    L(1:length(T)) = location;
    SP = arrayfun(@sun_position,T,transpose(L));
    angles = struct2table(SP);
    zenith = table2array(angles(:,1));
    azimuth = table2array(angles(:,2));
    elevation = 90-zenith;
    % export to .mat
    weather_data = [the_year the_month the_day the_hour zeros(size(the_year)) zeros(size(the_year)) GHI DNI DHI EHR zenith azimuth elevation];
    weather_data(8761,1:3) = [location.longitude location.latitude location.altitude];
    save(fileout_str,'weather_data');
end
