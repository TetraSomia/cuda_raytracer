#include <stdlib.h>
#include <math.h>
#include "core.h"

SDL_Surface *screen;

void putpixel(int x, int y, int color)
{
  unsigned int *ptr = (unsigned int*)screen->pixels;
  int lineoffset = y * (screen->pitch / 4);
  ptr[lineoffset + x] = color;
}

void render(s_data *data)
{
  if (SDL_MUSTLOCK(screen))
    if (SDL_LockSurface(screen) < 0)
      return;
/*
  data->meta.cam_rot.x = data->rotation + M_PI/2;
  data->meta.cam_pos.y = 5*cos(data->rotation);
  data->meta.cam_pos.z = 5*sin(data->rotation);
  data->rotation += M_PI / 1024;
*/
  launch_kernel(data);

  if (SDL_MUSTLOCK(screen))
    SDL_UnlockSurface(screen);
  SDL_UpdateRect(screen, 0, 0, W_X, W_Y);
}

int main(int argc, char *argv[])
{
  s_data data;

  if (SDL_Init(SDL_INIT_VIDEO) < 0)
    exit(1);
  atexit(SDL_Quit);
  screen = SDL_SetVideoMode(W_X, W_Y, 32, SDL_SWSURFACE);// | SDL_FULLSCREEN);
  if (screen == NULL)
    exit(1);
  init(&data, screen);
  while (1)
  {
    render(&data);
    if (key_listener(&data) == 1)
      return (0);
  }
}
