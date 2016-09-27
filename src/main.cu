#include <stdlib.h>
#include "core.h"
#include "keys.h"

void render(s_data *data)
{
  if (SDL_MUSTLOCK(data->screen))
    if (SDL_LockSurface(data->screen) < 0)
      return;

  launch_kernel(data);

  if (SDL_MUSTLOCK(data->screen))
    SDL_UnlockSurface(data->screen);
  SDL_UpdateRect(data->screen, 0, 0, W_X, W_Y);
}

int main(int argc, char *argv[])
{
  s_data data;

  if (SDL_Init(SDL_INIT_VIDEO) < 0)
    exit(1);
  atexit(SDL_Quit);
  data.screen = SDL_SetVideoMode(W_X, W_Y, 32, SDL_SWSURFACE);// | SDL_FULLSCREEN);
  if (data.screen == NULL)
    exit(1);
  init(&data);
  while (1)
  {
    render(&data);
    if (key_listener(&data) == 1)
    {
      cudaFree(data.g_sphere);
      cudaFree(data.g_pixels);
      cudaFree(data.g_meta);
      exit(0);
    }
  }
}
