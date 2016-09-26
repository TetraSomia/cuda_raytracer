#include "core.h"

__device__ void init_ray(s_var *var, s_meta* meta, int i)
{
  var->l_p = meta->light;
  var->c_p = meta->cam_pos;
  var->c_v.x = (W_X / 2) - (i % W_X);
  var->c_v.y = (W_Y / 2) - (i / W_Y);
  var->c_v.z = sqrtf(SQ(W_X) + SQ(W_Y));
  rot_vec(&var->c_v, meta->cam_rot);
}

__global__ void raytrace(s_meta* meta, const s_sphere *sphere, uint *pixels)
{
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  s_var var;

  // INTERSECT
  init_ray(&var, meta, i);
  intersect(&var, meta->nb_sphere, sphere);
  if (var.oc_d < 0.0f)
  {
    pixels[i] = 0;
    return;
  }

  // SHADERS
  light(&var, meta, sphere, &(pixels[i]));
  if (var.h_i >= 0 && !var.shadow)
    phong(&var);
}
