function emtp2mat

%       Wroclaw TU, Poland
%       June, 1997

  [pl4file,pat0] = uigetfile('*.pl4','Get File');
 
  fn=[pat0 pl4file];   
  fid=fopen(fn);
  %path(pat);
  if fid >= 0                           % file exists
    chr=fread(fid,1,'uchar');
    tnazg=[];
    tnazw=[];
    tnumw=[];
    if chr==' '                         % text file (formatted)
        NEWL=abs([13 10]);
        mpl4 = fread(fid);
        mpl4 = setstr(mpl4');
        lwez=sscanf(mpl4(21:28),'%i');
        lwna=sscanf(mpl4(29:36),'%i');
        lwyj=sscanf(mpl4(37:44),'%i');
        lgal=sscanf(mpl4(45:52),'%i');

        k=findstr(mpl4(1:100),NEWL);
        k=k(1)+11;
        for i=1:lgal-1,
          line=mpl4(k:k+7);
          l=findstr(line,NEWL);
          if l~=[], 
                k=k+l(1)+2;
                l=l(1)-1;
           else,
                l=6;
                k=k+7;
          end;
          y=str2mat(tnazg,line(1:l));           % branche names
        end;

        k=k+8;
        for i=1:lwez-1,
          line=mpl4(k:k+7);
          l=findstr(line,NEWL);
          if l~=[], 
                k=k+l(1)+2;
                l=l(1)-1;
           else,
                l=6;
                k=k+7;
          end;
          y=str2mat(tnazw,line(1:l));           % node names
        end;
        l=size(mpl4);
        l=l(2);
        [y,count,err,nxi]=sscanf(mpl4(k:l),'%i',lwyj);   % node numbers
        nxi=nxi+k;
        k=1+lwyj/2;
        mpl4=sscanf(mpl4(nxi:l),'%g',[k,inf]);

     elseif chr==43                             % unformatted file
        char=fseek(fid,20,'bof');
        lwez=fread(fid,1,'int32');
        lwna=fread(fid,1,'int32');
        lwyj=fread(fid,1,'int32');
        lgal=fread(fid,1,'int32');
        a=fread(fid,2,'int32');
        a=fread(fid,2,'char');
        k=46;
        if a(2)<255,
                a=a(2);
                p=1;
         else,
                p=4;
                a=fread(fid,1,'int32');
        end;

        y=fread(fid,6,'char');          % start of the branche names
        for i=1:lgal-1,
         y=fread(fid,6,'char');
         tnazg=str2mat(tnazg,setstr(y'));
        end;

        fseek(fid,p,0);
        a=fread(fid,2,'uchar');

        if a(1)<255,
                fseek(fid,-1,0);
                p=1;
         else,
                if a(2)<255,fseek(fid,-1,0); end;
                p=5;
                a=fread(fid,1,'int32');
        end;

        y=fread(fid,6,'char');          % start of the node names
        for i=1:lwez-1,
         y=fread(fid,6,'char');
         tnazw=str2mat(tnazw,setstr(y'));
        end;

        fseek(fid,p,0);
        a=fread(fid,3,'char');

        if a(3)==255,
          a=fread(fid,4,'char');
          p=6;
         else, p=2;
        end;

        for i=1:lwyj,
         y=fread(fid,1,'uint32');
         tnumw=[tnumw,y(1)];
        end;

        fseek(fid,p,0);                 % start of the data
        k=1+lwyj/2;
        s=0;
        i=0;
        mpl4=[];
        while s==0,
         i=i+1;
         mpl4(:,i)=fread(fid,k,'float');
         s=fseek(fid,2,0);
        end;

     else                                       % C-like file
        char=fseek(fid,19,'bof');
        lwez=fread(fid,1,'int32');
        lwna=fread(fid,1,'int32');
        lwyj=fread(fid,1,'int32');
        lgal=fread(fid,1,'int32');
        a=fread(fid,1,'int32');
        pocz=fread(fid,1,'int32')-1;
        konc=fread(fid,1,'int32');
        l1=53;
        fseek(fid,l1,'bof');            % start of the node names
        k=l1+6*lgal;
        char=fseek(fid,k,'bof');        % start of the output node names
        k=k+6*(lwez-1);
        char=fseek(fid,k,'bof');        % start of the output node numbers
        k=k+4*lwyj;
        k=pocz;
        fseek(fid,0,1);
        fend=ftell(fid);

        char=fseek(fid,k,'bof');        % start of the data
        k=1+lwyj/2;
        mpl4=fread(fid,[k,inf],'float');
    end;
    
[newmatfile, newpath] = uiputfile('*.mat', 'Save As');
fn=[newpath newmatfile];
eval(['save ' fn ' mpl4']);
fclose('all');
end;
