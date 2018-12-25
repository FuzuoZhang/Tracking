function res_c= detectcolor(frame, bboxes)

frame=im2uint8(frame);
n=size(bboxes,1);  %number of objects
res_c=cell(n,1);
for i=1:n
    x=bboxes(i,2)+floor(bboxes(i,4)/2);
    y=bboxes(i,1)+floor(bboxes(i,3)/2);
     if y<1 
        y=1;
    end
    if y>544
        y=544;
    end
    if x<1
        x=1;
    end
     if x>960
       x=960;
     end
    res_c(i)={[int2str(frame(x,y,1)),' ',int2str(frame(x,y,2)),' ',int2str(frame(x,y,3))]};
end
end

