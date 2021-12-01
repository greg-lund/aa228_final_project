/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * hooke_jeeves.c
 *
 * Code generation for function 'hooke_jeeves'
 *
 */

/* Include files */
#include "hooke_jeeves.h"
#include "rt_nonfinite.h"
#include "sim_rocket.h"
#include "rt_nonfinite.h"
#include <math.h>
#include <string.h>

/* Function Declarations */
static double rt_powd_snf(double u0, double u1);

/* Function Definitions */
static double rt_powd_snf(double u0, double u1)
{
  double d;
  double d1;
  double y;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = rtNaN;
  } else {
    d = fabs(u0);
    d1 = fabs(u1);
    if (rtIsInf(u1)) {
      if (d == 1.0) {
        y = 1.0;
      } else if (d > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (d1 == 0.0) {
      y = 1.0;
    } else if (d1 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > floor(u1))) {
      y = rtNaN;
    } else {
      y = pow(u0, u1);
    }
  }

  return y;
}

void hooke_jeeves(const double K[18], double m_rocket, double m_fuel, double g,
                  double Isp, double T_max, const double x_start[6], double
                  K_final[18], double *rewards)
{
  double K_best[18];
  double K_temp[18];
  double alpha;
  double reward;
  double reward_best;
  double reward_diff;
  int el;
  int j;
  alpha = 0.05;
  memcpy(&K_final[0], &K[0], 18U * sizeof(double));
  *rewards = sim_rocket(K, x_start, m_rocket, m_fuel, g, Isp, T_max);
  reward_diff = 1.0E+6;
  while ((alpha > 9.9999999999999991E-6) && (reward_diff > 9.9999999999999991E-6))
  {
    *rewards = sim_rocket(K_final, x_start, m_rocket, m_fuel, g, Isp, T_max);
    reward_best = *rewards - 1.0E+7;
    memcpy(&K_best[0], &K_final[0], 18U * sizeof(double));
    for (j = 0; j < 36; j++) {
      el = (int)ceil(((double)j + 1.0) / 2.0) - 1;
      memcpy(&K_temp[0], &K_final[0], 18U * sizeof(double));
      K_temp[el] = K_final[el] + rt_powd_snf(-1.0, fmod((double)j + 1.0, 2.0)) *
        alpha;
      reward = sim_rocket(K_temp, x_start, m_rocket, m_fuel, g, Isp, T_max);
      if (reward > reward_best) {
        reward_best = reward;
        memcpy(&K_best[0], &K_temp[0], 18U * sizeof(double));
      }
    }

    if (reward_best > *rewards) {
      reward_diff = reward_best - *rewards;
      *rewards = reward_best;
      memcpy(&K_final[0], &K_best[0], 18U * sizeof(double));
    } else {
      alpha *= 0.9;
    }
  }
}

/* End of code generation (hooke_jeeves.c) */
