function [VarName14,VarName15,VarName16] = importfile_EPW_solar(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [VARNAME14,VARNAME15,VARNAME16] = IMPORTFILE(FILENAME) Reads data from
%   text file FILENAME for the default selection.
%
%   [VARNAME14,VARNAME15,VARNAME16] = IMPORTFILE(FILENAME, STARTROW,
%   ENDROW) Reads data from rows STARTROW through ENDROW of text file
%   FILENAME.
%
% Example:
%   [VarName14,VarName15,VarName16] =
%   importfile('NLD_Amsterdam.062400_IWEC.csv',9, 8768);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2015/04/13 18:46:25

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 9;
    endRow = inf;
end

%% Format string for each line of text:
%   column14: double (%f)
%	column15: double (%f)
%   column16: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
VarName14 = dataArray{:, 1};
VarName15 = dataArray{:, 2};
VarName16 = dataArray{:, 3};

