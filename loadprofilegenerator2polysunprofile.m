%loadprofilegenerator2polysunprofile
%Script for reading loadprofilegenerator profiles and exporting them to the
%Polysun format.
dr = dir;
st = pwd;
time = (0:60:60*525600-60)';
heading2 = '#Generated with Load Profile Generator (http://www.loadprofilegenerator.de)\n';
heading3 = '#;\n';
heading4 = '#Time [s];Electric consumption [kWh]\n';
fs = '%d;%d\n';
for d = 3:numel(dr)
    try
        type = dr(d).name;
        csvname = strrep(type, ',', '');
        csvname = strrep(csvname, '- ', '-');
        csvname = strrep(csvname, ' -', '-');
        csvname = strrep(csvname, '+ ', '+');
        csvname = strrep(csvname, ' +', '+');
        csvname = ['eload_1min_', strrep(csvname, ' ', '_'), '.csv'];
        cd(fullfile(dr(d).name, 'Results'))
        fileID = fopen('Overall.SumProfiles.Electricity.csv','r');
        dataArray = textscan(fileID, '%*s%*s%f%[^\n\r]', 'Delimiter', ';', 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
        fclose(fileID);
        profile = dataArray{:, 1};
        cd(st)
        stind = strfind(type, ' ');
        stind = stind(1);
        heading1 = ['#Load profile: ', type(stind+1:end), '\n'];
        fid = fopen(csvname, 'w');
        fprintf(fid, heading1);
        fprintf(fid, heading2);
        fprintf(fid, heading3);
        fprintf(fid, heading4);
        fprintf(fid, fs, [time, profile]');
        fclose(fid);
    catch
    end
end
    