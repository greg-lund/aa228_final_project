/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_hooke_jeeves_api.h
 *
 * Code generation for function 'hooke_jeeves'
 *
 */

#ifndef _CODER_HOOKE_JEEVES_API_H
#define _CODER_HOOKE_JEEVES_API_H

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
  void hooke_jeeves(real_T K[18], real_T m_rocket, real_T m_fuel, real_T g,
                    real_T Isp, real_T T_max, real_T x_start[6], real_T K_final
                    [18], real_T *rewards);
  void hooke_jeeves_api(const mxArray * const prhs[7], int32_T nlhs, const
                        mxArray *plhs[2]);
  void hooke_jeeves_atexit(void);
  void hooke_jeeves_initialize(void);
  void hooke_jeeves_terminate(void);
  void hooke_jeeves_xil_shutdown(void);
  void hooke_jeeves_xil_terminate(void);

#ifdef __cplusplus

}
#endif
#endif

/* End of code generation (_coder_hooke_jeeves_api.h) */
