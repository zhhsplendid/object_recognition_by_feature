function main(  )
    
    fprintf('Be sure to add VLFeat path.\n');

    clear;
    close all;

    templatename = 'object-template.jpg';
    scenenames = {'object-template-rotated.jpg', 'scene1.jpg', 'scene2.jpg'};


    % Read in the object template image.  This is the thing we'll search for in
    % the scene images.
    im1 = im2single(rgb2gray(imread(templatename)));


    % Extract SIFT features from the template image.
    %
    % 'f' refers to a matrix of "frames".  It is 4 x n, where n is the number
    % of SIFT features detected.  Thus, each column refers to one SIFT descriptor.  
    % The first row gives the x positions, second row gives the y positions, 
    % third row gives the scales, fourth row gives the orientations.  You will
    % need the x and y positions for this assignment.
    %
    % 'd' refers to a matrix of "descriptors".  It is 128 x n.  Each column 
    % is a 128-dimensional SIFT descriptor.
    %
    % See VLFeats for more details on the contents of the frames and
    % descriptors.
    


    % Loop through the scene images and do some processing
    
    for scenenum = 1:length(scenenames)

        fprintf('Reading image %s for the scene to search....\n', scenenames{scenenum});
        im2 = im2single(rgb2gray(imread(scenenames{scenenum})));

        matchComparison(im1, im2);
        detectObject(im1, im2);
    end
    
    
    %Extra Examples
    
    %1 Success example
    templatename = 'book.jpg';
    im1 = im2single(rgb2gray(imread(templatename)));
    scenenames = {'book_on_table.jpg'}%, 'TianAnMen_fail_case'};
    for scenenum = 1:length(scenenames)

        fprintf('Reading image %s for the scene to search....\n', scenenames{scenenum});
        im2 = im2single(rgb2gray(imread(scenenames{scenenum})));

        %matchComparison(im1, im2);
        detectObject(im1, im2);
    end
    
    
end

