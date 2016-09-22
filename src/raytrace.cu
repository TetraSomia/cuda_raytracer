#include "core.h"

__device__ void get_hit_pos(s_var *var)
{
  var->h_p.x = var->c_p.x + var->oc_d * var->c_v.x;
  var->h_p.y = var->c_p.y + var->oc_d * var->c_v.y;
  var->h_p.z = var->c_p.z + var->oc_d * var->c_v.z;
}

__device__ void init_ray(s_var *var, float3 cam_pos, float3 cam_rot, int i)
{
  var->c_p = cam_pos;
  var->c_v.x = (W_X / 2.0f) - (i % W_X);
  var->c_v.y = (W_Y / 2.0f) - (i / W_Y);
  var->c_v.z = sqrtf(SQ(W_X) + SQ(W_Y));
  rot_vec(&var->c_v, cam_rot);
}

__device__ inline float3 get_sphere_pos(float4 sphere)
{
  return ((float3){sphere.x, sphere.x, sphere.z});
}

__global__ void raytrace(s_meta* meta, const float4 *sphere, uint *pixels)
{
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  s_var var;

  init_ray(&var, meta->cam_pos, meta->cam_rot, i);
  intersect_spheres(&var, meta->nb_sphere, sphere);
  if (var.oc_d < 0)
  {
    pixels[i] = 0;
    return;
  }
  get_hit_pos(&var);
  var.o_p = get_sphere_pos(sphere[var.h_i]);
  var.ol_v = vec_new_uni(var.h_p, meta->light);
  var.h_n = vec_new_uni(var.o_p, var.h_p);
  var.coef = vec_dot(var.ol_v, var.h_n);

  if (var.coef < 0)
    var.coef = 0;
  if (var.coef > 1)
    var.coef = 1;

  var.coef *= 255.0f;
  pixels[i] = RGB((int)var.coef, (int)var.coef, (int)var.coef);
}
