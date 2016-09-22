#include "core.h"

__device__ float solve_sphere_line_intersect(float3 p, float3 v, float4 sphere)
{
  float3 cst;
  float delta;
  float2 sol;

  cst.x = SQ(v.x) + SQ(v.y) + SQ(v.z);
  cst.y = 2 * (v.x * (p.x - sphere.x)
	       + v.y * (p.y - sphere.y)
	       + v.z * (p.z - sphere.z));
  cst.z = -2 * (sphere.x * p.x + sphere.y * p.y
    + sphere.z * p.z)
    + SQ(sphere.x) + SQ(sphere.y) + SQ(sphere.z) - SQ(sphere.w)
    + SQ(p.x) + SQ(p.y) + SQ(p.z);
  delta = SQ(cst.y) - (4 * cst.x * cst.z);
  if (delta < 0 || cst.x == 0)
    return (-1);
  sol.x = (-(cst.y) + sqrt(delta)) / (2 * cst.x);
  sol.y = (-(cst.y) - sqrt(delta)) / (2 * cst.x);
  if (sol.x >= 0 && sol.y >= 0)
    return (MIN(sol.x, sol.y));
  return (MAX(sol.x, sol.y));
}

__device__ void intersect(s_var *var, int nb_sphere, const float4 *sphere)
{
  float k;

  var->oc_d = INFINITE;
  for (int i = 0; i < nb_sphere; i++)
  {
    k = solve_sphere_line_intersect(var->c_p, var->c_v, sphere[i]);
    if (k >= 0 && k < var->oc_d)
    {
      var->oc_d = k;
      var->h_i = i;
    }
  }
  k = -var->c_p.z/var->c_v.z;
  if (k >= 0 && k < var->oc_d)
  {
    var->oc_d = k;
    var->h_i = -1;
  }
  if (var->oc_d == INFINITE)
    var->oc_d = -1;
}

__device__ bool is_shadow(s_var *var, int nb_sphere, const float4 *sphere)
{
  float k;
  float k_min = INFINITE;
  int i_min = -1;
  float3 lo_v = vec_inv(var->ol_v);

  for (int i = 0; i < nb_sphere; i++)
  {
    k = solve_sphere_line_intersect(var->l_p, lo_v, sphere[i]);
    if (k >= 0 && k < k_min)
    {
      k_min = k;
      i_min = i;
    }
  }
  if (i_min < 0 && var->h_i >= 0)
    return (false);
  return (i_min ^ var->h_i);
}
