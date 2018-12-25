function bg = getbackground(filename)
%提取视频中的背景，简单起见直接用第一帧
obj= vision.VideoFileReader(filename);
while ~isDone(obj)
   bg=obj.step();
   break;
end
end

