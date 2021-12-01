/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sim_rocket.c
 *
 * Code generation for function 'sim_rocket'
 *
 */

/* Include files */
#include "sim_rocket.h"
#include "rt_nonfinite.h"
#include "rt_nonfinite.h"
#include <math.h>

/* Function Definitions */
double sim_rocket(const double K_vec[18], const double x0[6], double m_rocket,
                  double m_fuel, double g, double Isp, double T_max)
{
  static const double dv[3] = { 0.0, 0.0, 9.81 };

  double b_K_vec[18];
  double x[6];
  double T[3];
  double T_mag;
  double m;
  double m_empty;
  double varargin_1_idx_0;
  int b_i;
  int i;
  m_empty = m_rocket - m_fuel;
  for (i = 0; i < 6; i++) {
    x[i] = x0[i];
  }

  m = m_rocket;
  while (x[2] > 0.0) {
    if (m > m_empty) {
      for (i = 0; i < 18; i++) {
        b_K_vec[i] = -K_vec[i];
      }

      for (i = 0; i < 3; i++) {
        T_mag = 0.0;
        for (b_i = 0; b_i < 6; b_i++) {
          T_mag += b_K_vec[i + 3 * b_i] * x[b_i];
        }

        T[i] = m * (T_mag + dv[i]);
      }

      /*              T = K*x; */
      T_mag = sqrt((T[0] * T[0] + T[1] * T[1]) + T[2] * T[2]);
      varargin_1_idx_0 = T_max / T_mag;
      if ((varargin_1_idx_0 > 1.0) || rtIsNaN(varargin_1_idx_0)) {
        varargin_1_idx_0 = 1.0;
      }

      T[0] *= varargin_1_idx_0;
      T[1] *= varargin_1_idx_0;
      T[2] *= varargin_1_idx_0;
    } else {
      T[0] = 0.0;
      T[1] = 0.0;
      T[2] = 0.0;
      T_mag = 0.0;
    }

    x[0] += x[3] * 0.01;
    x[1] += x[4] * 0.01;
    x[2] += x[5] * 0.01;
    x[3] += T[0] / m * 0.01;
    x[4] += T[1] / m * 0.01;
    x[5] += (T[2] / m - g) * 0.01;
    m -= T_mag / (Isp * g) * 0.01;
  }

  T_mag = m_rocket - m;
  return -((((x[0] * x[0] + x[1] * x[1]) + x[2] * x[2]) + 10.0 * ((x[3] * x[3] +
              x[4] * x[4]) + x[5] * x[5])) + T_mag * T_mag);
}

/* End of code generation (sim_rocket.c) */
