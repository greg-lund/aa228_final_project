/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * hooke_jeeves.h
 *
 * Code generation for function 'hooke_jeeves'
 *
 */

#ifndef HOOKE_JEEVES_H
#define HOOKE_JEEVES_H

/* Include files */
#include "rtwtypes.h"
#include <stddef.h>
#include <stdlib.h>
#ifdef __cplusplus

extern "C" {

#endif

  /* Function Declarations */
  extern void hooke_jeeves(const double K[18], double m_rocket, double m_fuel,
    double g, double Isp, double T_max, const double x_start[6], double K_final
    [18], double *rewards);

#ifdef __cplusplus

}
#endif
#endif

/* End of code generation (hooke_jeeves.h) */
