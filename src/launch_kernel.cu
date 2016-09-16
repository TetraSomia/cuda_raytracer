#include "core.h"

void launch_kernel(s_data *data)
{
  float4 *g_sphere;
  uint *g_pixels;

  cudaMalloc(&g_sphere, data->nb_sphere * sizeof(float4));
  cudaMalloc(&g_pixels, N * sizeof(uint));
  cudaMemcpy(g_sphere, data->sphere, data->nb_sphere * sizeof(float4), cudaMemcpyHostToDevice);
  cudaMemcpy(g_pixels, data->pixels, N * sizeof(uint), cudaMemcpyHostToDevice);
  raytrace<<<N/THREADS, THREADS>>>(data->cam_pos, data->cam_rot, data->nb_sphere, g_sphere, g_pixels);
  cudaMemcpy(data->pixels, g_pixels, N * sizeof(uint), cudaMemcpyDeviceToHost);
}
