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
  double b_K_vec[18];
  double x[6];
  double y[3];
  double T_idx_0;
  double T_idx_1;
  double T_idx_2;
  double T_mag;
  double m;
  double m_empty;
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

        y[i] = T_mag;
      }

      T_idx_0 = m * y[0];
      T_idx_1 = m * y[1];
      T_idx_2 = m * (y[2] + g);
      if (!(0.0 < T_idx_2)) {
        T_idx_2 = 0.0;
      }

      T_mag = T_max / sqrt((T_idx_0 * T_idx_0 + T_idx_1 * T_idx_1) + T_idx_2 *
                           T_idx_2);
      if ((T_mag > 1.0) || rtIsNaN(T_mag)) {
        T_mag = 1.0;
      }

      T_idx_0 *= T_mag;
      T_idx_1 *= T_mag;
      T_idx_2 *= T_mag;
      T_mag = sqrt((T_idx_0 * T_idx_0 + T_idx_1 * T_idx_1) + T_idx_2 * T_idx_2);
    } else {
      T_idx_0 = 0.0;
      T_idx_1 = 0.0;
      T_idx_2 = 0.0;
      T_mag = 0.0;
    }

    x[0] += x[3] * 0.01;
    x[1] += x[4] * 0.01;
    x[2] += x[5] * 0.01;
    x[3] += T_idx_0 / m * 0.01;
    x[4] += T_idx_1 / m * 0.01;
    x[5] += (T_idx_2 / m - g) * 0.01;
    m -= T_mag / (Isp * 9.81) * 0.01;
  }

  T_mag = m_rocket - m;
  return -((((x[0] * x[0] + x[1] * x[1]) + x[2] * x[2]) + 10.0 * ((x[3] * x[3] +
              x[4] * x[4]) + x[5] * x[5])) + 68.5 / m_rocket * (T_mag * T_mag));
}

/* End of code generation (sim_rocket.c) */
