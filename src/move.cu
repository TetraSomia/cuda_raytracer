#include <math.h>
#include "core.h"


int     key_forward(s_data *data)
{
  data->meta.cam_pos.x += MOVE * cos(data->meta.cam_rot.z);
  data->meta.cam_pos.y += MOVE * sin(data->meta.cam_rot.z);
  return (0);
}

int     key_backward(s_data *data)
{
  data->meta.cam_pos.x -= MOVE * cos(data->meta.cam_rot.z);
  data->meta.cam_pos.y -= MOVE * sin(data->meta.cam_rot.z);
  return (0);
}

int     key_left(s_data *data)
{
  data->meta.cam_pos.x += MOVE * cos(data->meta.cam_rot.z + M_PI / 2);
  data->meta.cam_pos.y += MOVE * sin(data->meta.cam_rot.z + M_PI / 2);
  return (0);
}

int     key_right(s_data *data)
{
  data->meta.cam_pos.x -= MOVE * cos(data->meta.cam_rot.z + M_PI / 2);
  data->meta.cam_pos.y -= MOVE * sin(data->meta.cam_rot.z + M_PI / 2);
  return (0);
}

int     key_up(s_data *data)
{
  data->meta.cam_pos.z += MOVE;
  return (0);
}

int     key_down(s_data *data)
{
  data->meta.cam_pos.z -= MOVE;
  return (0);
}

int	key_left_rotate(s_data *data)
{
  data->meta.cam_rot.z += ROT;
  return (0);
}

int	key_right_rotate(s_data *data)
{
  data->meta.cam_rot.z -= ROT;
  return (0);
}

int	key_up_rotate(s_data *data)
{
  data->meta.cam_rot.x -= ROT;
  return (0);
}

int	key_down_rotate(s_data *data)
{
  data->meta.cam_rot.x += ROT;
  return (0);
}


int key_listener(s_data *data)
{
  SDL_Event event;
  Uint8 *keystate = SDL_GetKeyState(NULL);

  if (keystate[SDLK_q])
    key_forward(data);
  if (keystate[SDLK_d])
    key_backward(data);
  if (keystate[SDLK_s])
    key_left(data);
  if (keystate[SDLK_z])
    key_right(data);
  if (keystate[SDLK_r])
    key_up(data);
  if (keystate[SDLK_f])
    key_down(data);
  if (keystate[SDLK_LEFT])
    key_left_rotate(data);
  if (keystate[SDLK_RIGHT])
    key_right_rotate(data);
  if (keystate[SDLK_UP])
    key_up_rotate(data);
  if (keystate[SDLK_DOWN])
    key_down_rotate(data);

  while (SDL_PollEvent(&event))
  {
    switch (event.type)
    {
    case SDL_KEYDOWN:
      break;
    case SDL_KEYUP:
      if (event.key.keysym.sym == SDLK_ESCAPE)
        return (1);
/*
      if (event.key.keysym.sym == SDLK_q)
        key_forward(data);
      if (event.key.keysym.sym == SDLK_d)
        key_backward(data);
      if (event.key.keysym.sym == SDLK_s)
        key_left(data);
      if (event.key.keysym.sym == SDLK_z)
        key_right(data);
*/
      break;
    case SDL_QUIT:
      return (1);
    }
  }
  return (0);
}
