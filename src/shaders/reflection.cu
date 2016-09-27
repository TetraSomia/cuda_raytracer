#include "core.h"

__device__ void reflection(s_var *var, const s_meta* meta, const s_sphere *sphere, uint *pix)
{
  s_var var_reflect;
  uint pix_reflect;

  var_reflect.l_p = var->l_p;
  var_reflect.c_p = var->h_p;
  var_reflect.c_v = vec_reflec(var->h_n, var->oc_v);
  intersect_spheres(&var_reflect, meta->nb_sphere, sphere);
  if (var_reflect.oc_d < 0.0f)
    pix_reflect = 0;
  else
    light(&var_reflect, meta, sphere, &pix_reflect);
  uint r,g,b;
  r = (GET_R(*pix) + GET_R(*pix) + GET_R(pix_reflect)) / 3;
  g = (GET_G(*pix) + GET_G(*pix) + GET_G(pix_reflect)) / 3;
  b = (GET_B(*pix) + GET_B(*pix) + GET_B(pix_reflect)) / 3;
  *pix = RGB(r, g, b);
}
