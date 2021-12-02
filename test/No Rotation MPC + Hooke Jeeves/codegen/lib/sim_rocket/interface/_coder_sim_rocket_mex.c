/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_sim_rocket_mex.c
 *
 * Code generation for function 'sim_rocket'
 *
 */

/* Include files */
#include "_coder_sim_rocket_mex.h"
#include "_coder_sim_rocket_api.h"

/* Function Definitions */
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&sim_rocket_atexit);
  /* Module initialization. */
  sim_rocket_initialize();
  /* Dispatch the entry-point. */
  unsafe_sim_rocket_mexFunction(nlhs, plhs, nrhs, prhs);
  /* Module termination. */
  sim_rocket_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2021a(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1,
                           NULL);
  return emlrtRootTLSGlobal;
}

void unsafe_sim_rocket_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
                                   const mxArray *prhs[9])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *outputs;
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 9) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 9, 4,
                        10, "sim_rocket");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 10,
                        "sim_rocket");
  }
  /* Call the function. */
  sim_rocket_api(prhs, &outputs);
  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, &plhs[0], &outputs);
}

/* End of code generation (_coder_sim_rocket_mex.c) */
