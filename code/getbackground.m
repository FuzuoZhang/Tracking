function bg = getbackground(filename)
%��ȡ��Ƶ�еı����������ֱ���õ�һ֡
obj= vision.VideoFileReader(filename);
while ~isDone(obj)
   bg=obj.step();
   break;
end
end

