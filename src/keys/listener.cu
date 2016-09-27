#include "core.h"
#include "keys.h"

void change_moved_object(s_data *data)
{
  data->moved_object++;
  if (data->moved_object == data->meta.nb_sphere)
    data->moved_object = CAMERA;
}

int key_listener(s_data *data)
{
  SDL_Event event;
  Uint8 *keystate = SDL_GetKeyState(NULL);

  for (int i = 0; g_key_callback_tab[i].callback != NULL; i++)
  {
    if (keystate[g_key_callback_tab[i].key])
      g_key_callback_tab[i].callback(data);
  }

  while (SDL_PollEvent(&event))
  {
    switch (event.type)
    {
    case SDL_KEYDOWN:
      break;
    case SDL_KEYUP:
      if (event.key.keysym.sym == SDLK_ESCAPE)
        return (1);
      if (event.key.keysym.sym == SDLK_a)
        change_moved_object(data);
      break;
    case SDL_QUIT:
      return (1);
    }
  }
  return (0);
}
