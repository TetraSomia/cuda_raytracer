#include "core.h"

void init(s_data *data)
{
  data->moved_object = -1;
  data->pixels = (unsigned int*)data->screen->pixels;
  data->meta.nb_sphere = 2;
  data->sphere = (s_sphere*)malloc(data->meta.nb_sphere * sizeof(s_sphere));
  data->sphere[1].pos.x = 0;
  data->sphere[1].pos.y = 0;
  data->sphere[1].pos.z = 1;
  data->sphere[1].r = 1;
  data->sphere[1].color = RGB(255, 0, 0);
  data->sphere[0].pos.x = 0;
  data->sphere[0].pos.y = 3;
  data->sphere[0].pos.z = 1;
  data->sphere[0].r = 1;
  data->sphere[0].color = RGB(0, 255, 0);
  data->meta.cam_pos.x = 0;
  data->meta.cam_pos.y = 5;
  data->meta.cam_pos.z = 1;
  data->meta.cam_rot.x = M_PI/2;
  data->meta.cam_rot.y = 0;
  data->meta.cam_rot.z = 0;
  data->meta.light.x = 5;
  data->meta.light.y = 5;
  data->meta.light.z = 5;
  cudaMalloc(&data->g_sphere, data->meta.nb_sphere * sizeof(s_sphere));
  cudaMalloc(&data->g_pixels, N * sizeof(uint));
  cudaMalloc(&data->g_meta, sizeof(s_meta));
}
