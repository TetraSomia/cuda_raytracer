#include "core.h"

void launch_kernel(s_data *data)
{
  s_sphere *g_sphere;
  uint *g_pixels;
  s_meta *g_meta;

  cudaMalloc(&g_sphere, data->meta.nb_sphere * sizeof(s_sphere));
  cudaMalloc(&g_pixels, N * sizeof(uint));
  cudaMalloc(&g_meta, sizeof(s_meta));
  cudaMemcpy(g_sphere, data->sphere, data->meta.nb_sphere * sizeof(s_sphere), cudaMemcpyHostToDevice);
  cudaMemcpy(g_pixels, data->pixels, N * sizeof(uint), cudaMemcpyHostToDevice);
  cudaMemcpy(g_meta, &data->meta, sizeof(s_meta), cudaMemcpyHostToDevice);
  raytrace<<<N/THREADS, THREADS>>>(g_meta, g_sphere, g_pixels);
  cudaMemcpy(data->pixels, g_pixels, N * sizeof(uint), cudaMemcpyDeviceToHost);
  cudaFree(g_sphere);
  cudaFree(g_pixels);
  cudaFree(g_meta);
}
