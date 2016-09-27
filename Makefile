NAME	=	cuda_rt

CC		=	nvcc

INC		=	./include/

FLAGS	=	-rdc=true -I$(INC) \
				`sdl-config --cflags --libs`

SRCS	=	./src/

KEYS 	= ./src/keys/

SRC		=	$(SRCS)main.cu \
				$(SRCS)init.cu \
				$(SRCS)launch_kernel.cu \
				$(SRCS)raytrace.cu \
				$(SRCS)rotate.cu \
				$(SRCS)intersect.cu \
				$(SRCS)vector.cu \
				$(SRCS)light.cu \
				$(SRCS)phong.cu \
				$(KEYS)move.cu \
				$(KEYS)listener.cu

RM		=	rm -f

all:	$(NAME)

$(NAME):
			$(CC) $(SRC) -o $(NAME) $(FLAGS)

clean:
			$(RM) $(NAME)

re:		clean all
