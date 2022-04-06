function [AllPic_Feature,All_Labels] = strimagetest()
  fidin = fopen('test-01-images.svm'); % ��test2.txt�ļ� 
  j = 1;
  apres = [];
   AllPic_Feature = [];
   All_Labels=[];
while ~feof(fidin)
  tline = fgetl(fidin); % ���ļ����� 
  apres{j} = tline;
  % �������
  a = char(apres(j));
  All_Labels = [All_Labels;str2num(a(1:2))];
  lena = size(a);
  lena = lena(2);
  xy = sscanf(a(4:lena), '%d:%d');
  lenxy = size(xy);
  lenxy = lenxy(1);
  grid = [];
  grid(784) = 0;
  for i=2:2:lenxy  %% ��һ����
      if(xy(i)<=0)
          break
      end
    grid(xy(i-1)) = xy(i) * 100/255;
  end
  grid1 = reshape(grid,28,28);
  grid1 = fliplr(diag(ones(28,1)))*grid1;
  grid1 = rot90(grid1,3);
  image_f = extractLBPFeatures(grid1);
  AllPic_Feature = [AllPic_Feature;image_f];
  
  j = j+1;
end
%  
%    
%   a = char(apres(n));
%   
%   lena = size(a);
%   lena = lena(2);
%   xy = sscanf(a(4:lena), '%d:%d');
% 
%   lenxy = size(xy);
%   lenxy = lenxy(1);
%   
%   
%   grid = [];
%   grid(784) = 0;
%   for i=2:2:lenxy  %% ��һ����
%       if(xy(i)<=0)
%           break
%       end
%     grid(xy(i-1)) = xy(i) * 100/255;
%   end
%   grid1 = reshape(grid,28,28);
%   grid1 = fliplr(diag(ones(28,1)))*grid1;
%   grid1 = rot90(grid1,3);
%   %image(grid1)
%   %hold on;
end
