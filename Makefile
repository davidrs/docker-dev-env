NAME = dev-img

build:
	docker build -t $(NAME) .

# Launches you into it with a bash terminal.
run-bash: build
	docker run  -it --rm -p 8887:8887 -v $(HOME)/.aws:/home/.aws  -v $(PWD):/docker-dev  $(NAME) bash

run-jupyter: build
	docker run  -it --rm -p 8889:8889 -v $(HOME)/.aws:/home/.aws  -v $(PWD):/docker-dev  $(NAME) jupyter notebook --ip=0.0.0.0 --port=8889 --allow-root

# requires docker image dymat/opencv
run-cv2:
	## Run these first:
	# open -a XQuartz
	# export ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}');
  # xhost + $ip)
	
	# Can't use 'docker bash' or it won't work.
	# Container being used here is: dymat/opencv
	docker run -it  -e DISPLAY=$(ip):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $(PWD):/docker-dev \
	 -v $(PWD)/simple-image-labeler/images:/images \
	  dymat/opencv python /docker-dev/simple-image-labeler/main.py;




run: run-bash
