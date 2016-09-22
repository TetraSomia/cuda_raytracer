#pragma once
#include "SDL.h"

#define W_X (800)
#define W_Y (800)
#define N (W_X * W_Y)
#define THREADS (512)
#define INFINITE (500)
#define MOVE (0.01)
#define ROT (M_PI / 1024)

#define RGB(r, g, b) ((r) * 0x10000 + (g) * 0x100 + (b))
#define MAP(x, ba, ea, bb, eb) ((((ba - x) / (ba - ea)) * (eb - bb)) + bb)
#define ABS(x) ((x) < 0 ? -(x) : (x))
#define SQ(x) ((x) * (x))
#define MAX(a,b) (((a)>(b))?(a):(b))
#define MIN(a,b) (((a)<(b))?(a):(b))
#define SET_REL_COLOR(x, a, b) (RGB(MAP(x, a, b, 0, 255), MAP(x, a, b, 0, 255), MAP(x, a, b, 0, 255)))

//  c -> camera
//  o -> object
//  h -> hited
//  l -> light

//  v -> vector
//  p -> point
//  n -> normal
//  d -> distance

struct s_var
{
  float3 c_v;
  float3 c_p;
  float3 o_p;
  float3 ol_v;
  float3 h_n;
  float3 h_p;
  float oc_d;
  float coef;
  int h_i;
};

struct s_meta
{
  float3 cam_pos;
  float3 cam_rot;
  float3 light;
  uint nb_sphere;
};

struct s_data
{
  s_meta meta;
  float4 *sphere;
  uint *pixels;
  float rotation;
};

void init(s_data *data, SDL_Surface *screen);
void launch_kernel(s_data *data);
int key_listener(s_data *data);

__global__ void raytrace(s_meta* meta, const float4 *sphere, uint *pixels);
__device__ void	rot_vec(float3 *vec, float3 angle);
__device__ void intersect_spheres(s_var *var, uint nb_sphere, const float4 *sphere);

__device__ float vec_dot(float3 v1, float3 v2);
__device__ float3 vec_new(float3 p1, float3 p2);
__device__ float3 vec_new_uni(float3 p1, float3 p2);
