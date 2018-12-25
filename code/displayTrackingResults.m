function displayTrackingResults()
        % Convert the frame and the mask to uint8 RGB.
global obj;
global frame;
global tracks;
global bboxes;
global mask;
global tracking;
       frame = im2uint8(frame);
        mask = uint8(repmat(mask, [1, 1, 3])) .* 255;

        minVisibleCount = 1;
        if ~isempty(tracks)

            % Noisy detections tend to result in short-lived tracks.
            % Only display tracks that have been visible for more than
            % a minimum number of frames.
            reliableTrackInds = ...
                [tracks(:).totalVisibleCount] > minVisibleCount;
            reliableTracks = tracks(reliableTrackInds);
            
            % Display the objects. If an object has not been detected
            % in this frame, display its predicted bounding box.
            if ~isempty(reliableTracks)
                % Get bounding boxes.
                bboxes = cat(1, reliableTracks.bbox);
                res= detectcolor(frame, bboxes);   %%%objects' color 
                % Get ids.
                %ids = int32([reliableTracks(:).id]);   %%mark   
                % Create labels for objects indicating the ones for
                % which we display the predicted rather than the actual
                % location.
               % labels = cellstr(int2str(ids')) ;  %%mark
                %labels=cellstr(int2str(res));
                labels=res;
                predictedTrackInds = ...
                    [reliableTracks(:).consecutiveInvisibleCount] > 0;
                isPredicted = cell(size(labels));
                isPredicted(predictedTrackInds) = {' predicted'};
                labels = strcat(labels, isPredicted);
                frame = insertObjectAnnotation(frame, 'rectangle', ...
                    bboxes, labels,'color','red');

                % Draw the objects on the mask.
                mask = insertObjectAnnotation(mask, 'rectangle', ...
                    bboxes, labels);
            end
        end
       
       
         for i=1:size(tracking,1)
                    y=tracking(i,1);
                    x=tracking(i,2);
                    y1=max(1,y-5);
                    y2=min(544,y+5);
                    x1=max(1,x-5);
                    x2=min(960,x+5);
                    frame(x1:x2,y1:y2,1)=0;
                    frame(x1:x2,y1:y2,2)=0;
                    frame(x1:x2,y1:y2,3)=255;
         end
        % Display the mask and the frame.
        %obj.maskPlayer.step(mask);
       obj.videoPlayer.step(frame);
    end