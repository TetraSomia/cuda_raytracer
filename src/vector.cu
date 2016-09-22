#include <math.h>
#include "core.h"

__device__ float vec_dot(float3 v1, float3 v2)
{
  return (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z);
}

__device__ float3 vec_new(float3 p1, float3 p2)
{
  return ((float3){p2.x - p1.x, p2.y - p1.y, p2.z - p1.z});
}

__device__ float3 vec_new_uni(float3 p1, float3 p2)
{
  float mult;
  float3 v;

  v.x = p2.x - p1.x;
  v.y = p2.y - p1.y;
  v.z = p2.z - p1.z;
  mult = 1.0f / sqrtf(SQ(v.x) + SQ(v.y) + SQ(v.z));
  v.x *= mult;
  v.y *= mult;
  v.z *= mult;
  return (v);
}
