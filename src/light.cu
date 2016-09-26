#include "core.h"

__device__ void get_hit_pos(s_var *var)
{
  var->h_p.x = var->c_p.x + var->oc_d * var->c_v.x;
  var->h_p.y = var->c_p.y + var->oc_d * var->c_v.y;
  var->h_p.z = var->c_p.z + var->oc_d * var->c_v.z;
}

__device__ void light(s_var *var, s_meta* meta, const s_sphere *sphere, uint *pix)
{
  get_hit_pos(var);
  if (var->h_i == -1)
  {
    var->h_n.x = 0.0f;
    var->h_n.y = 0.0f;
    var->h_n.z = 1.0f;
  }
  else
  {
    var->o_p = sphere[var->h_i].pos;
    var->h_n = vec_new_uni(var->o_p, var->h_p);
  }

  var->ol_v = vec_new_uni(var->h_p, var->l_p);
  float coef = vec_dot(var->ol_v, var->h_n);

  var->shadow = is_shadow(var, meta->nb_sphere, sphere);
  if (coef < 0.1f || var->shadow)
    coef = 0.1f;

  if (var->h_i == -1)
  {
    coef *= 255.0f;
    *pix = RGB((int)coef, (int)coef, (int)coef);
  }
  else
  {
    *pix = RGB(GET_R(sphere[var->h_i].color, coef),
    GET_G(sphere[var->h_i].color, coef),
    GET_B(sphere[var->h_i].color, coef));
  }
}
