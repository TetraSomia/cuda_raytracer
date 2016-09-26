#include <math.h>
#include "core.h"

__device__ void phong(s_var *var)
{
  var->oc_v = vec_new_uni(var->h_p, var->c_p);
  var->ol_r = vec_reflec(var->h_n, var->ol_v);
  float coef = vec_dot(var->oc_v, var->ol_r);
  if (coef < 0)
    return;
  if (coef > 1)
    coef = 1;
  coef = powf(coef, PHONG_SIZE);
  //var->coef += coef;
}
