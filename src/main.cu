#include <stdlib.h>
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

  launch_kernel(data);
  /*
  for (int i = 0; i < W_Y; i++)
  {
    for (int j = 0; j < W_X; j++)
    {
      putpixel(j, i, rand()%0x00ffffff);
    }
  }
*/

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
    SDL_Event event;
    while (SDL_PollEvent(&event))
    {
      switch (event.type)
      {
      case SDL_KEYDOWN:
        break;
      case SDL_KEYUP:
        if (event.key.keysym.sym == SDLK_ESCAPE)
          return 0;
        break;
      case SDL_QUIT:
        return(0);
      }
    }
  }
}
