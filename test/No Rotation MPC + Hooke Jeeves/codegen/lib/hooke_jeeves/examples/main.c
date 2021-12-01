/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * main.c
 *
 * Code generation for function 'main'
 *
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

/* Include files */
#include "main.h"
#include "hooke_jeeves.h"
#include "hooke_jeeves_terminate.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static void argInit_3x6_real_T(double result[18]);
static void argInit_6x1_real_T(double result[6]);
static double argInit_real_T(void);
static void main_hooke_jeeves(void);

/* Function Definitions */
static void argInit_3x6_real_T(double result[18])
{
  int idx0;
  int idx1;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 3; idx0++) {
    for (idx1 = 0; idx1 < 6; idx1++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result[idx0 + 3 * idx1] = argInit_real_T();
    }
  }
}

static void argInit_6x1_real_T(double result[6])
{
  int idx0;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 6; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

static double argInit_real_T(void)
{
  return 0.0;
}

static void main_hooke_jeeves(void)
{
  double K_final[18];
  double dv[18];
  double dv1[6];
  double m_rocket_tmp;
  double rewards;

  /* Initialize function 'hooke_jeeves' input arguments. */
  /* Initialize function input argument 'K'. */
  m_rocket_tmp = argInit_real_T();

  /* Initialize function input argument 'x_start'. */
  /* Call the entry-point 'hooke_jeeves'. */
  argInit_3x6_real_T(dv);
  argInit_6x1_real_T(dv1);
  hooke_jeeves(dv, m_rocket_tmp, m_rocket_tmp, m_rocket_tmp, m_rocket_tmp,
               m_rocket_tmp, dv1, K_final, &rewards);
}

int main(int argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* The initialize function is being called automatically from your entry-point function. So, a call to initialize is not included here. */
  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_hooke_jeeves();

  /* Terminate the application.
     You do not need to do this more than one time. */
  hooke_jeeves_terminate();
  return 0;
}

/* End of code generation (main.c) */
