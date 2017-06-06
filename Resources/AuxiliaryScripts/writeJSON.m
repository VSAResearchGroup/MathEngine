function [retval_tf] = writeJSON(obj, rootname)
        fileStr = savejson(rootname, obj);
        fid=fopen(strcat(rootname,'.json'),'w');
        fprintf(fid, fileStr);
        fclose(fid);
        retval_tf = true;
        
        %variable = loadjson('filename');       %reads a json file
endfunction