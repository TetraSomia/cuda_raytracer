#include <math.h>
#include "core.h"

__device__ void phong(s_var *var, uint *pix)
{
  var->ol_r = vec_reflec(var->h_n, var->ol_v);
  float coef = vec_dot(var->oc_v, var->ol_r);
  if (coef < 0)
    return;
  coef = powf(coef, PHONG_SIZE);
  uint r,g,b;
  r = ((255 - GET_R(*pix)) / 2) * coef + GET_R(*pix);
  g = ((255 - GET_G(*pix)) / 2) * coef + GET_G(*pix);
  b = ((255 - GET_B(*pix)) / 2) * coef + GET_B(*pix);
  *pix = RGB(r, g, b);
}
