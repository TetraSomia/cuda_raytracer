#include "core.h"

void init(s_data *data, SDL_Surface *screen)
{
  data->pixels = (unsigned int*)screen->pixels;
  data->nb_sphere = 1;
  data->sphere = (float4*)malloc(data->nb_sphere * sizeof(float4));
  data->sphere[0].x = 0;
  data->sphere[0].y = 0;
  data->sphere[0].z = 10;
  data->sphere[0].w = 1;
  data->cam_pos.x = 0;
  data->cam_pos.y = 0;
  data->cam_pos.z = 0;
  data->cam_rot.x = 0;
  data->cam_rot.y = 0;
  data->cam_rot.z = 0;
}
