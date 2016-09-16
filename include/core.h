#pragma once
#include "SDL.h"

#define W_X (800)
#define W_Y (800)
#define N (W_X * W_Y)
#define THREADS (512)
#define INFINITE (500)

#define RGB(r, g, b) ((r) * 0x10000 + (g) * 0x100 + (b))
#define MAP(x, ba, ea, bb, eb) ((((ba - x) / (ba - ea)) * (eb - bb)) + bb)
#define ABS(x) ((x) < 0 ? -(x) : (x))
#define SQ(x) ((x) * (x))
#define MAX(a,b) (((a)>(b))?(a):(b))
#define MIN(a,b) (((a)<(b))?(a):(b))
#define SET_REL_COLOR(x, a, b) (RGB(MAP(x, a, b, 0, 255), MAP(x, a, b, 0, 255), MAP(x, a, b, 0, 255)))

struct s_var
{
  float3 c_v;
  float3 c_p;
  float oc_d;
};

struct s_data
{
  float3 cam_pos;
  float3 cam_rot;
  float4 *sphere;
  uint nb_sphere;
  uint *pixels;
};

void init(s_data *data, SDL_Surface *screen);
void launch_kernel(s_data *data);

__global__ void raytrace(float3 cam_pos, float3 cam_rot, uint nb_sphere, const float4 *sphere, uint *pixels);
__device__ void	rot_vec(float3 *vec, float3 angle);
__device__ void intersect_spheres(s_var *var, uint nb_sphere, const float4 *sphere);
