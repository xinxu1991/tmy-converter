function [VarName7,VarName8,VarName9,VarName10] = importfile_EPW_location(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [VARNAME7,VARNAME8,VARNAME9,VARNAME10] = IMPORTFILE(FILENAME) Reads
%   data from text file FILENAME for the default selection.
%
%   [VARNAME7,VARNAME8,VARNAME9,VARNAME10] = IMPORTFILE(FILENAME, STARTROW,
%   ENDROW) Reads data from rows STARTROW through ENDROW of text file
%   FILENAME.
%
% Example:
%   [VarName7,VarName8,VarName9,VarName10] =
%   importfile('NLD_Amsterdam.062400_IWEC.csv',1, 1);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2015/04/13 19:46:16

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = 1;
end

%% Format string for each line of text:
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
%	column10: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
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
VarName7 = dataArray{:, 1};
VarName8 = dataArray{:, 2};
VarName9 = dataArray{:, 3};
VarName10 = dataArray{:, 4};
