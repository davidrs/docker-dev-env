Docker file for doing imaged based ML anywhere.

## Features
- `make run-jupyter` running a jupyter notebook at localhost:8889
- `simple-image-labeler`: a quick tool I made for allowing you to label images using your keyboard.
- `repo` folder will git ignore content, but is where you can clone other repos.
- Instructions below for running cv2 with imshow from docker.


## Suggested repos
- imagenet-downloader - Helps download images from http://www.image-net.org
- [tensorflow-for-poets](https://codelabs.developers.google.com/codelabs/tensorflow-for-poets/#5) - simple tool tutorial / tool for running an image classifier.


## Using repo to make an image classifier:

1. Use simple-image-labeler or imagenet-downloader to make some training data.
2. Run [tensorflow-for-poets](https://codelabs.developers.google.com/codelabs/tensorflow-for-poets/#5) training code.
```
# ran main dev docker:
IMAGE_SIZE=224
ARCHITECTURE="mobilenet_0.50_${IMAGE_SIZE}"

# To train the model.
python -m scripts.retrain \
  --bottleneck_dir=tf_files/bottlenecks \
  --how_many_training_steps=500 \
  --model_dir=tf_files/models/ \
  --summaries_dir=tf_files/training_summaries/"${ARCHITECTURE}" \
  --output_graph=tf_files/retrained_graph.pb \
  --output_labels=tf_files/retrained_labels.txt \
  --architecture="${ARCHITECTURE}" \
  --image_dir=tf_files/backpage_photos
```

3. Run model on some images. This is a script I made so it handles an entire folder.
```
# To have model run on folder of images, and move the potential matches to a new folder.
python -m scripts.label_images   \    
--graph=tf_files/retrained_graph.pb  \      
--image_folder=tf_files/backpage_unlabeled/ \
--label_of_interest=hotel
```

## Getting imshow to work from docker on Mac
How to get cv2.imshow to work from within docker. Needed for simple-image-labeler.

1) Download and install Quartz [https://www.xquartz.org/]. Since on newer Macs they no longer shipped with X11.
2) Cmds:
```
open -a XQuartz

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

xhost + $ip

# Can't use 'docker bash' or it won't work.
# Container being used here is: dymat/opencv
docker run -it –rm -e DISPLAY=$ip:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $(PWD):/drs \
  -v $(PWD)/simple-image-labeler/images:/images \
  dymat/opencv python /docker-dev/photo-categorization/main.py
```
