##
## Makefile for fdf in /home/josso_a/rendu/info/gfx_fdf1
##
## Made by josso_a
## Login   <arthur.josso@epitech.eu>
##
## Started on  Tue Nov 10 14:09:31 2015 josso_a
## Last update Thu Sep 15 21:54:17 2016 josso_a
##

NAME    = 	cuda_rt

CC	= 	nvcc

INC     =       ./include/

FLAGS	=	-rdc=true -I$(INC) \
		`sdl-config --cflags --libs`

SRCS	=	./src/

SRC	= 	$(SRCS)main.cu \
				$(SRCS)init.cu \
				$(SRCS)launch_kernel.cu \
				$(SRCS)raytrace.cu \
				$(SRCS)rotate.cu \
				$(SRCS)sphere.cu

RM	= 	rm -f

all:	$(NAME)

$(NAME):
	$(CC) $(SRC) -o $(NAME) $(FLAGS)

clean:
	$(RM) $(NAME)

re:	clean all
