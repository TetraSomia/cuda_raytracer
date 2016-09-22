NAME	=	cuda_rt

CC		=	nvcc

INC		=	./include/

FLAGS	=	-rdc=true -I$(INC) \
				`sdl-config --cflags --libs`

SRCS	=	./src/

SRC		=	$(SRCS)main.cu \
				$(SRCS)init.cu \
				$(SRCS)launch_kernel.cu \
				$(SRCS)raytrace.cu \
				$(SRCS)rotate.cu \
				$(SRCS)intersect.cu \
				$(SRCS)move.cu \
				$(SRCS)vector.cu

RM		=	rm -f

all:	$(NAME)

$(NAME):
			$(CC) $(SRC) -o $(NAME) $(FLAGS)

clean:
			$(RM) $(NAME)

re:		clean all
