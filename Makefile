NAME = dev-img

build:
	docker build -t $(NAME) .

# Launches you into it with a bash terminal.
run-bash: build
	docker run  -it --rm -p 8888:8888 -v $(HOME)/.aws:/home/.aws  -v $(PWD):/docker-dev  $(NAME) bash
	# Run inside docker once it's up
	# jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root

run-jupyter: build
	docker run  -it --rm -p 8889:8889 -v $(HOME)/.aws:/home/.aws  -v $(PWD):/docker-dev  $(NAME) jupyter notebook --ip=0.0.0.0 --port=8889 --allow-root


run: run-bash
