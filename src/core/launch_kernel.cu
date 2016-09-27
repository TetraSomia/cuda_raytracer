#include "core.h"

void launch_kernel(s_data *data)
{
  cudaMemcpy(data->g_sphere, data->sphere, data->meta.nb_sphere * sizeof(s_sphere), cudaMemcpyHostToDevice);
  cudaMemcpy(data->g_pixels, data->pixels, N * sizeof(uint), cudaMemcpyHostToDevice);
  cudaMemcpy(data->g_meta, &data->meta, sizeof(s_meta), cudaMemcpyHostToDevice);
  raytrace<<<N/THREADS, THREADS>>>(data->g_meta, data->g_sphere, data->g_pixels);
  cudaMemcpy(data->pixels, data->g_pixels, N * sizeof(uint), cudaMemcpyDeviceToHost);
}
