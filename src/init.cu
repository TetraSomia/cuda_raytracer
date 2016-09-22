#include "core.h"

void init(s_data *data, SDL_Surface *screen)
{
  data->rotation = 0;
  data->pixels = (unsigned int*)screen->pixels;
  data->meta.nb_sphere = 1;
  data->sphere = (float4*)malloc(data->meta.nb_sphere * sizeof(float4));
  data->sphere[0].x = 0;
  data->sphere[0].y = 0;
  data->sphere[0].z = 0;
  data->sphere[0].w = 1;
  data->meta.cam_pos.x = 0;
  data->meta.cam_pos.y = 5;
  data->meta.cam_pos.z = 0;
  data->meta.cam_rot.x = M_PI/2;
  data->meta.cam_rot.y = 0;
  data->meta.cam_rot.z = 0;
  data->meta.light.x = 5;
  data->meta.light.y = 5;
  data->meta.light.z = 5;
}
