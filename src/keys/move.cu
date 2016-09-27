#include <math.h>
#include "core.h"
#include "keys.h"

s_key_callback g_key_callback_tab[] =
{
  {SDLK_q, &key_forward},
  {SDLK_d, &key_backward},
  {SDLK_s, &key_left},
  {SDLK_z, &key_right},
  {SDLK_r, &key_up},
  {SDLK_f, &key_down},
  {SDLK_LEFT, &key_left_rotate},
  {SDLK_RIGHT, &key_right_rotate},
  {SDLK_UP, &key_up_rotate},
  {SDLK_DOWN, &key_down_rotate},
  {SDLK_UNKNOWN, NULL}
};

void key_forward(s_data *data)
{
  if (data->moved_object == CAMERA)
  {
    data->meta.cam_pos.x += MOVE * cos(data->meta.cam_rot.z);
    data->meta.cam_pos.y += MOVE * sin(data->meta.cam_rot.z);
  }
  else
  {
    data->sphere[data->moved_object].pos.x += MOVE * cos(data->meta.cam_rot.z);
    data->sphere[data->moved_object].pos.y += MOVE * sin(data->meta.cam_rot.z);
  }
}

void key_backward(s_data *data)
{
  if (data->moved_object == CAMERA)
  {
    data->meta.cam_pos.x -= MOVE * cos(data->meta.cam_rot.z);
    data->meta.cam_pos.y -= MOVE * sin(data->meta.cam_rot.z);
  }
  else
  {
    data->sphere[data->moved_object].pos.x -= MOVE * cos(data->meta.cam_rot.z);
    data->sphere[data->moved_object].pos.y -= MOVE * sin(data->meta.cam_rot.z);
  }
}

void key_left(s_data *data)
{
  if (data->moved_object == CAMERA)
  {
    data->meta.cam_pos.x += MOVE * cos(data->meta.cam_rot.z + M_PI / 2);
    data->meta.cam_pos.y += MOVE * sin(data->meta.cam_rot.z + M_PI / 2);
  }
  else
  {
    data->sphere[data->moved_object].pos.x += MOVE * cos(data->meta.cam_rot.z + M_PI / 2);
    data->sphere[data->moved_object].pos.y += MOVE * sin(data->meta.cam_rot.z + M_PI / 2);
  }
}

void key_right(s_data *data)
{
  if (data->moved_object == CAMERA)
  {
    data->meta.cam_pos.x -= MOVE * cos(data->meta.cam_rot.z + M_PI / 2);
    data->meta.cam_pos.y -= MOVE * sin(data->meta.cam_rot.z + M_PI / 2);
  }
  else
  {
    data->sphere[data->moved_object].pos.x -= MOVE * cos(data->meta.cam_rot.z + M_PI / 2);
    data->sphere[data->moved_object].pos.y -= MOVE * sin(data->meta.cam_rot.z + M_PI / 2);
  }
}

void key_up(s_data *data)
{
  if (data->moved_object == CAMERA)
    data->meta.cam_pos.z += MOVE;
  else
    data->sphere[data->moved_object].pos.z += MOVE;
}

void key_down(s_data *data)
{
  if (data->moved_object == CAMERA)
    data->meta.cam_pos.z -= MOVE;
  else
    data->sphere[data->moved_object].pos.z -= MOVE;
}

void key_left_rotate(s_data *data)
{
  data->meta.cam_rot.z += ROT;
}

void key_right_rotate(s_data *data)
{
  data->meta.cam_rot.z -= ROT;
}

void key_up_rotate(s_data *data)
{
  data->meta.cam_rot.x -= ROT;
}

void key_down_rotate(s_data *data)
{
  data->meta.cam_rot.x += ROT;
}
