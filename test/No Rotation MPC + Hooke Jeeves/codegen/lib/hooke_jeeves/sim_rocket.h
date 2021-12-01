/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sim_rocket.h
 *
 * Code generation for function 'sim_rocket'
 *
 */

#ifndef SIM_ROCKET_H
#define SIM_ROCKET_H

/* Include files */
#include "rtwtypes.h"
#include <stddef.h>
#include <stdlib.h>
#ifdef __cplusplus

extern "C" {

#endif

  /* Function Declarations */
  double sim_rocket(const double K_vec[18], const double x0[6], double m_rocket,
                    double m_fuel, double g, double Isp, double T_max);

#ifdef __cplusplus

}
#endif
#endif

/* End of code generation (sim_rocket.h) */
