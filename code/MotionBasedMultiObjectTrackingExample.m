
function MotionBasedMultiObjectTrackingExample(filename)
% Create System objects used for reading video, detecting moving objects,
% and displaying the results.
global obj;
global frame;
global tracks;
global nextId;
global centroids;
global bboxes;
global mask;
global assignments;
global unassignedTracks;
global unassignedDetections;
global bg;
global tracking;
tracking=[];
% Create System objects used for reading video, detecting moving objects,
% and displaying the results.
obj = setupSystemObjects(filename);

tracks = initializeTracks(); % Create an empty array of tracks.

nextId = 1; % ID of the next track
 bg=getbackground(filename);
% Detect moving objects, and track them across video frames.
while ~isDone(obj.reader)
    frame = readFrame();
    [centroids, bboxes, mask] = detectObjects(frame);
    tracking=[tracking;floor(centroids)];
    predictNewLocationsOfTracks();
    [assignments, unassignedTracks, unassignedDetections] = ...
    detectionToTrackAssignment();
    updateAssignedTracks();
    updateUnassignedTracks();
    deleteLostTracks();
    createNewTracks();
    %mydisplay(res)
    displayTrackingResults();
end
