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
                  double m_fuel, double g, double Isp, double T_max,
                  double omega, double lat)
{
  static const signed char a[18] = {0, 0, 0, 1, 0, 0, 0, 0, 0,
                                    0, 1, 0, 0, 0, 0, 0, 0, 1};
  static const signed char iv[18] = {0, 0, 0, 0, 0, 0, 0, 0, 0,
                                     1, 0, 0, 0, 1, 0, 0, 0, 1};
  double A[36];
  double b_K_vec[18];
  double Sw[9];
  double b_Sw[9];
  double x[6];
  double y[6];
  double b_omega[3];
  double w_T[3];
  double A_tmp;
  double m;
  double m_empty;
  double theta;
  int b_A_tmp;
  int b_i;
  int i;
  /*  CHANGES WITH ROTATION */
  /*  When adding in rotational speed, follow the same steps as in run_mpc.m. */
  /*  Also, make sure to MEX this using the MATLAB coder app after you make any
   */
  /*  changes or they won't be included! */
  /*  Runs the simulation to the ground and calculates the reward for a given K
   */
  m_empty = m_rocket - m_fuel;
  /*  kg */
  /*  m/s^2 */
  /*  Simulation step size */
  for (i = 0; i < 6; i++) {
    x[i] = x0[i];
  }
  /*  State vector (contains x, y, z, vx, vy, vz) - m or m/s */
  m = m_rocket;
  /*  Starting mass (kg) */
  /*  Angular velocity vector in ECI fram (rad/s); */
  /*  Update angle of rotation (theta) given latitude */
  theta = 0.0;
  if (lat >= 0.0) {
    theta = 90.0 - lat;
  } else if (lat < 0.0) {
    theta = fabs(lat) + 90.0;
  }
  theta *= 0.017453292519943295;
  /*  Rotation matrix for rotation of theta about e3 unit vector */
  A_tmp = sin(theta);
  theta = cos(theta);
  /*  Rotated angular velocity vector in target reference frame(rad/s) */
  Sw[0] = theta;
  Sw[3] = A_tmp;
  Sw[6] = 0.0;
  Sw[1] = -A_tmp;
  Sw[4] = theta;
  Sw[7] = 0.0;
  Sw[2] = 0.0;
  Sw[5] = 0.0;
  Sw[8] = 1.0;
  for (b_i = 0; b_i < 3; b_i++) {
    w_T[b_i] = Sw[b_i] * omega + Sw[b_i + 3] * 0.0;
  }
  Sw[0] = 0.0;
  Sw[3] = -w_T[2];
  Sw[6] = w_T[1];
  Sw[1] = w_T[2];
  Sw[4] = 0.0;
  Sw[7] = -w_T[0];
  Sw[2] = -w_T[1];
  Sw[5] = w_T[0];
  Sw[8] = 0.0;
  for (b_i = 0; b_i < 3; b_i++) {
    for (i = 0; i < 3; i++) {
      b_Sw[b_i + 3 * i] =
          -((Sw[b_i] * Sw[3 * i] + Sw[b_i + 3] * Sw[3 * i + 1]) +
            Sw[b_i + 6] * Sw[3 * i + 2]);
    }
  }
  for (b_i = 0; b_i < 6; b_i++) {
    A[6 * b_i] = iv[3 * b_i];
    A[6 * b_i + 1] = iv[3 * b_i + 1];
    A[6 * b_i + 2] = iv[3 * b_i + 2];
  }
  for (b_i = 0; b_i < 3; b_i++) {
    A[6 * b_i + 3] = b_Sw[3 * b_i];
    i = 6 * (b_i + 3);
    A[i + 3] = -2.0 * Sw[3 * b_i];
    b_A_tmp = 3 * b_i + 1;
    A[6 * b_i + 4] = b_Sw[b_A_tmp];
    A[i + 4] = -2.0 * Sw[b_A_tmp];
    b_A_tmp = 3 * b_i + 2;
    A[6 * b_i + 5] = b_Sw[b_A_tmp];
    A[i + 5] = -2.0 * Sw[b_A_tmp];
  }
  while (x[0] > 0.0) {
    /*  See run_mpc.m for documentation of simulation documentation. This */
    /*  block is identical to the one in run_mpc.m */
    if (m > m_empty) {
      for (b_i = 0; b_i < 18; b_i++) {
        b_K_vec[b_i] = -K_vec[b_i];
      }
      for (b_i = 0; b_i < 3; b_i++) {
        A_tmp = 0.0;
        for (i = 0; i < 6; i++) {
          A_tmp += b_K_vec[b_i + 3 * i] * x[i];
        }
        b_omega[b_i] = A_tmp;
      }
      w_T[0] = m * (b_omega[0] + g);
      w_T[1] = m * b_omega[1];
      w_T[2] = m * b_omega[2];
      if (!(0.0 < w_T[0])) {
        w_T[0] = 0.0;
      }
      theta =
          T_max / sqrt((w_T[0] * w_T[0] + w_T[1] * w_T[1]) + w_T[2] * w_T[2]);
      if ((theta > 1.0) || rtIsNaN(theta)) {
        theta = 1.0;
      }
      w_T[0] *= theta;
      w_T[1] *= theta;
      w_T[2] *= theta;
      theta = sqrt((w_T[0] * w_T[0] + w_T[1] * w_T[1]) + w_T[2] * w_T[2]);
    } else {
      w_T[0] = 0.0;
      w_T[1] = 0.0;
      w_T[2] = 0.0;
      theta = 0.0;
    }
    b_omega[0] = -g + w_T[0] / m;
    b_omega[1] = w_T[1] / m;
    b_omega[2] = w_T[2] / m;
    for (b_i = 0; b_i < 6; b_i++) {
      A_tmp = 0.0;
      for (i = 0; i < 6; i++) {
        A_tmp += A[b_i + 6 * i] * x[i];
      }
      y[b_i] =
          A_tmp +
          (((double)a[b_i] * b_omega[0] + (double)a[b_i + 6] * b_omega[1]) +
           (double)a[b_i + 12] * b_omega[2]);
    }
    x[0] += x[3] * 0.01;
    x[1] += x[4] * 0.01;
    x[2] += x[5] * 0.01;
    x[3] += y[3] * 0.01;
    x[4] += y[4] * 0.01;
    x[5] += y[5] * 0.01;
    m -= theta / (Isp * 9.81) * 0.01;
  }
  /*  Quadratic cost function that weighs high velocity of impact higher */
  /*  than high distance from the goal position. */
  /*  68.5/m_rocket is a normalization factor to weight the used fuel by */
  /*  the proper amount to get a good optimization */
  theta = m_rocket - m;
  return -((((x[0] * x[0] + x[1] * x[1]) + x[2] * x[2]) +
            10.0 * ((x[3] * x[3] + x[4] * x[4]) + x[5] * x[5])) +
           68.5 / m_rocket * (theta * theta));
}

/* End of code generation (sim_rocket.c) */
