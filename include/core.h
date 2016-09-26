#pragma once
#include "SDL.h"

#define W_X (1024)
#define W_Y (1024)
#define N (W_X * W_Y)
#define THREADS (512)
#define INFINITE (50.0f)
#define MOVE (0.01f)
#define ROT (M_PI / 1024.0f)
#define PHONG_SIZE (32)

#define RGB(r, g, b) ((r) * 0x10000 + (g) * 0x100 + (b))
#define GET_R(x, y) ((int)((y) * (((x) >> 16) & 0xFF)))
#define GET_G(x, y) ((int)((y) * (((x) >> 8) & 0xFF)))
#define GET_B(x, y) ((int)((y) * ((x) & 0xFF)))
#define MAP(x, ba, ea, bb, eb) ((((ba - x) / (ba - ea)) * (eb - bb)) + bb)
#define ABS(x) ((x) < 0 ? -(x) : (x))
#define SQ(x) ((x) * (x))
#define MAX(a,b) (((a)>(b))?(a):(b))
#define MIN(a,b) (((a)<(b))?(a):(b))

//  c -> camera
//  o -> object
//  h -> hited
//  l -> light

//  v -> vector
//  p -> point
//  n -> normal
//  d -> distance
//  r -> reflected

struct s_var
{
  float3 c_v;
  float3 c_p;
  float3 l_p;
  float3 o_p;
  float3 ol_v;
  float3 ol_r;
  float3 h_n;
  float3 h_p;
  float3 oc_v;
  float oc_d;
  int h_i;
  bool shadow;
};

struct s_meta
{
  float3 cam_pos;
  float3 cam_rot;
  float3 light;
  int nb_sphere;
};

struct s_sphere
{
  float3 pos;
  float r;
  uint color;
};

struct s_data
{
  s_meta meta;
  s_sphere *sphere;
  uint *pixels;
  float rotation;
};

void init(s_data *data, SDL_Surface *screen);
void launch_kernel(s_data *data);
int key_listener(s_data *data);

__global__ void raytrace(s_meta* meta, const s_sphere *sphere, uint *pixels);
__device__ void	rot_vec(float3 *vec, float3 angle);
__device__ void intersect(s_var *var, int nb_sphere, const s_sphere *sphere);
__device__ void light(s_var *var, s_meta* meta, const s_sphere *sphere, uint *pix);
__device__ void phong(s_var *var);
__device__ bool is_shadow(s_var *var, int nb_sphere, const s_sphere *sphere);

__device__ float vec_dot(float3 v1, float3 v2);
__device__ float3 vec_inv(float3 v);
__device__ float3 vec_new(float3 p1, float3 p2);
__device__ float3 vec_new_uni(float3 p1, float3 p2);
__device__ float3 vec_reflec(float3 n, float3 l);
