/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_sim_rocket_api.h
 *
 * Code generation for function 'sim_rocket'
 *
 */

#ifndef _CODER_SIM_ROCKET_API_H
#define _CODER_SIM_ROCKET_API_H

/* Include files */
#include "emlrt.h"
#include "tmwtypes.h"
#include <string.h>

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus

extern "C" {

#endif

  /* Function Declarations */
  real_T sim_rocket(real_T K_vec[18], real_T x0[6], real_T m_rocket, real_T
                    m_fuel, real_T g, real_T Isp, real_T T_max);
  void sim_rocket_api(const mxArray * const prhs[7], const mxArray *plhs[1]);
  void sim_rocket_atexit(void);
  void sim_rocket_initialize(void);
  void sim_rocket_terminate(void);
  void sim_rocket_xil_shutdown(void);
  void sim_rocket_xil_terminate(void);

#ifdef __cplusplus

}
#endif
#endif

/* End of code generation (_coder_sim_rocket_api.h) */
