#include "core.h"

__device__ float solve_sphere_cam_intersect(s_var *var, float4 sphere)
{
  float3 cst;
  float delta;
  float2 sol;

  cst.x = SQ(var->c_v.x) + SQ(var->c_v.y) + SQ(var->c_v.z);
  cst.y = 2 * (var->c_v.x * (var->c_p.x - sphere.x)
	       + var->c_v.y * (var->c_p.y - sphere.y)
	       + var->c_v.z * (var->c_p.z - sphere.z));
  cst.z = -2 * (sphere.x * var->c_p.x + sphere.y * var->c_p.y
    + sphere.z * var->c_p.z)
    + SQ(sphere.x) + SQ(sphere.y) + SQ(sphere.z) - SQ(sphere.w)
    + SQ(var->c_p.x) + SQ(var->c_p.y) + SQ(var->c_p.z);
  delta = SQ(cst.y) - (4 * cst.x * cst.z);
  if (delta < 0 || cst.x == 0)
    return (-1);
  sol.x = (-(cst.y) + sqrt(delta)) / (2 * cst.x);
  sol.y = (-(cst.y) - sqrt(delta)) / (2 * cst.x);
  if (sol.x >= 0 && sol.y >= 0)
    return (MIN(sol.x, sol.y));
  return (MAX(sol.x, sol.y));
}

__device__ void intersect_spheres(s_var *var, uint nb_sphere, const float4 *sphere)
{
  float k;

  var->oc_d = INFINITE;
  for (int i = 0; i < nb_sphere; i++)
  {
    k = solve_sphere_cam_intersect(var, sphere[i]);
    if (k >= 0 && k < var->oc_d)
      var->oc_d = k;
  }
}
