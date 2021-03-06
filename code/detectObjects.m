 function [centroids, bboxes, mask] = detectObjects(frame)
global obj;
          % Detect foreground.
        frame_hsv=rgb2hsv(frame);
        mask = obj.detector.step(frame_hsv(:,:,1));
        % Apply morphological operations to remove noise and fill in holes.
        mask = imopen(mask, strel('rectangle', [3,3]));
        mask = imclose(mask, strel('rectangle', [5, 5]));
        mask = imfill(mask, 'holes');
        % Perform blob analysis to find connected components.
        [~, centroids, bboxes] = obj.blobAnalyser.step(mask);
        
    end