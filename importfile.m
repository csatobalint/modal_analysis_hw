function M = importfile(filename, startRow, endRow)

    delimiter = '\t';
    if nargin<=2
        startRow = 85;
        endRow = 6485;
    end

    formatSpec = '%f%f%f%f%[^\n\r]';

    fileID = fopen(filename,'r');

    try
        dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
        for block=2:length(startRow)
            frewind(fileID);
            dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
            for col=1:length(dataArray)
                dataArray{col} = [dataArray{col};dataArrayBlock{col}];
            end
        end
            fclose(fileID);
            M = [dataArray{1:end-1}];
    catch
        warning(['File ' filename 'does not exist!']);
        M=0;
    end
end




