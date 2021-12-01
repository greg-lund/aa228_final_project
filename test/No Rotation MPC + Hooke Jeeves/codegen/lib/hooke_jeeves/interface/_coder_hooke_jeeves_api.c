/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_hooke_jeeves_api.c
 *
 * Code generation for function 'hooke_jeeves'
 *
 */

/* Include files */
#include "_coder_hooke_jeeves_api.h"
#include "_coder_hooke_jeeves_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;
emlrtContext emlrtContextGlobal = { true,/* bFirstTime */
  false,                               /* bInitialized */
  131595U,                             /* fVersionInfo */
  NULL,                                /* fErrorFunction */
  "hooke_jeeves",                      /* fFunctionName */
  NULL,                                /* fRTCallStack */
  false,                               /* bDebugMode */
  { 2045744189U, 2170104910U, 2743257031U, 4284093946U },/* fSigWrd */
  NULL                                 /* fSigMem */
};

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[18];
static const mxArray *b_emlrt_marshallOut(const real_T u);
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *m_rocket,
  const char_T *identifier);
static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *x_start,
  const char_T *identifier))[6];
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *K, const
  char_T *identifier))[18];
static const mxArray *emlrt_marshallOut(const real_T u[18]);
static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[6];
static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[18];
static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static real_T (*i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[6];

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[18]
{
  real_T (*y)[18];
  y = g_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static const mxArray *b_emlrt_marshallOut(const real_T u)
{
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m);
  return y;
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *m_rocket,
  const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(m_rocket), &thisId);
  emlrtDestroyArray(&m_rocket);
  return y;
}

static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = h_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *x_start,
  const char_T *identifier))[6]
{
  emlrtMsgIdentifier thisId;
  real_T (*y)[6];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(x_start), &thisId);
  emlrtDestroyArray(&x_start);
  return y;
}
  static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *K, const
  char_T *identifier))[18]
{
  emlrtMsgIdentifier thisId;
  real_T (*y)[18];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(K), &thisId);
  emlrtDestroyArray(&K);
  return y;
}

static const mxArray *emlrt_marshallOut(const real_T u[18])
{
  static const int32_T iv[2] = { 0, 0 };

  static const int32_T iv1[2] = { 3, 6 };

  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateNumericArray(2, &iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m, iv1, 2);
  emlrtAssign(&y, m);
  return y;
}

static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[6]
{
  real_T (*y)[6];
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[18]
{
  static const int32_T dims[2] = { 3, 6 };

  real_T (*ret)[18];
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[18])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  real_T ret;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[6]
{
  static const int32_T dims[1] = { 6 };

  real_T (*ret)[6];
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  ret = (real_T (*)[6])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  void hooke_jeeves_api(const mxArray * const prhs[7], int32_T nlhs, const
  mxArray *plhs[2])
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  real_T (*K)[18];
  real_T (*K_final)[18];
  real_T (*x_start)[6];
  real_T Isp;
  real_T T_max;
  real_T g;
  real_T m_fuel;
  real_T m_rocket;
  real_T rewards;
  st.tls = emlrtRootTLSGlobal;
  K_final = (real_T (*)[18])mxMalloc(sizeof(real_T [18]));

  /* Marshall function inputs */
  K = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "K");
  m_rocket = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "m_rocket");
  m_fuel = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "m_fuel");
  g = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[3]), "g");
  Isp = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[4]), "Isp");
  T_max = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[5]), "T_max");
  x_start = e_emlrt_marshallIn(&st, emlrtAlias(prhs[6]), "x_start");

  /* Invoke the target function */
  hooke_jeeves(*K, m_rocket, m_fuel, g, Isp, T_max, *x_start, *K_final, &rewards);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*K_final);
  if (nlhs > 1) {
    plhs[1] = b_emlrt_marshallOut(rewards);
  }
}

void hooke_jeeves_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  hooke_jeeves_xil_terminate();
  hooke_jeeves_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void hooke_jeeves_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

void hooke_jeeves_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (_coder_hooke_jeeves_api.c) */
