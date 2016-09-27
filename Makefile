NAME	=	cuda_rt

CC		=	nvcc

INC		=	./include/

FLAGS	=	-rdc=true -ftz=true -prec-div=false -prec-sqrt=false -use_fast_math \
				--gpu-architecture=sm_52 -I$(INC) \
				`sdl-config --cflags --libs`

SRCS	=	./src/

KEYS 	= ./src/keys/

SHADERS	=	./src/shaders/

MATH 	= ./src/math/

CORE 	=	./src/core/

SRC		=	$(SRCS)main.cu \
				$(SRCS)init.cu \
				$(CORE)launch_kernel.cu \
				$(CORE)raytrace.cu \
				$(CORE)intersect.cu \
				$(MATH)rotate.cu \
				$(MATH)vector.cu \
				$(SHADERS)light.cu \
				$(SHADERS)phong.cu \
				$(KEYS)move.cu \
				$(KEYS)listener.cu

RM		=	rm -f

all:	$(NAME)

$(NAME):
			$(CC) $(SRC) -o $(NAME) $(FLAGS)

clean:
			$(RM) $(NAME)

re:		clean all
