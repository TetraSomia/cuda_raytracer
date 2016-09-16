#include "core.h"

__device__ void init_ray(s_var *var, float3 cam_pos, float3 cam_rot, int i)
{
  var->c_p = cam_pos;
  var->c_v.x = (W_X / 2.0f) - (i % W_X);
  var->c_v.y = (W_Y / 2.0f) - (i / W_Y);
  var->c_v.z = sqrtf(SQ(W_X) + SQ(W_Y));
  rot_vec(&var->c_v, cam_rot);
}

__global__ void raytrace(float3 cam_pos, float3 cam_rot, uint nb_sphere, const float4 *sphere, uint *pixels)
{
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  s_var var;

  init_ray(&var, cam_pos, cam_rot, i);
  intersect_spheres(&var, nb_sphere, sphere);
  pixels[i] = SET_REL_COLOR(var.oc_d, 50, 0);
}
