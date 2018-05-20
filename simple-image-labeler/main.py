
# import the necessary packages
import cv2
import os, os.path
import ntpath

#debug info OpenCV version
print ("OpenCV version: " + cv2.__version__)

MAX_FILES = 90

# Update these for different categories and keys
key_codes = {
    '97':'hotel', # 'a' == 97
    '108':'not-hotel', # 'l' ==
    '32':'unsure' # 'spacebar' == 32
}


#image path and valid extensions
imageDir = "images/uncategorized" #specify your path here
valid_image_extensions = [".jpg", ".jpeg", ".png", ".tif", ".tiff"] #specify your valid extensions here
valid_image_extensions = [item.lower() for item in valid_image_extensions]



def setup():
    # create necessary folders
    for k in key_codes:
        if not os.path.exists(key_codes[k]):
            os.makedirs('/'+key_codes[k]+'/')


def show_all_images():
    #create a list all files in directory and
    #append files with a vaild extention to image_path_list
    image_path_list = []
    for file in os.listdir(imageDir):
        extension = os.path.splitext(file)[1]
        if extension.lower() not in valid_image_extensions:
            continue
        image_path_list.append(os.path.join(imageDir, file))

    # TODO: shuffle images, then take first MAX_FILES
    image_path_list = image_path_list[:MAX_FILES]

    #loop through image_path_list to open each image
    for imagePath in image_path_list:
        image = cv2.imread(imagePath)

        # display the image on screen with imshow()
        # after checking that it loaded
        if image is not None:
            cv2.imshow(imagePath, image)
        elif image is None:
            print ("Error loading: " + imagePath)
            #end this loop iteration and move on to next image
            continue

        # wait time in milliseconds
        # this is required to show the image
        # 0 = wait indefinitely
        key = cv2.waitKey(0)
        if key == 27: # escape
            # exit when escape key is pressed
            break
        elif str(key) in key_codes:
            print key
            move_image(imagePath, key_codes[str(key)])
        else:
            print 'unkown key %s' % key
            cv2.destroyAllWindows()


def move_image(imagePath, folder):
    print 'Move %s to %s'% (imagePath, '/'+folder + '/' + path_leaf(imagePath))
    # os.rename(imagePath, folder + '/' + path_leaf(imagePath))
    os.rename(imagePath, 'images/'+folder + '/' + path_leaf(imagePath))


def path_leaf(path):
    head, tail = ntpath.split(path)
    print head
    return tail or ntpath.basename(head)

# Main:
setup()
show_all_images()
cv2.destroyAllWindows()
