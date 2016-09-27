__device__ void	rot_x(float3 *vec, float angle)
{
  float		tmp;

  tmp = vec->y;
  vec->y = tmp * cosf(angle) + vec->z * -sinf(angle);
  vec->z = tmp * sinf(angle) + vec->z * cosf(angle);
}

__device__ void    rot_y(float3 *vec, float angle)
{
  float		tmp;

  tmp = vec->x;
  vec->x = tmp * cosf(angle) + vec->z * sinf(angle);
  vec->z = tmp * -sinf(angle) + vec->z * cosf(angle);
}

__device__ void    rot_z(float3 *vec, float angle)
{
  float		tmp;

  tmp = vec->x;
  vec->x = tmp * cosf(angle) + vec->y * -sinf(angle);
  vec->y = tmp * sinf(angle) + vec->y * cosf(angle);
}

__device__ void	rot_vec(float3 *vec, float3 angle)
{
  rot_x(vec, angle.x);
  rot_y(vec, angle.y);
  rot_z(vec, angle.z);
}
