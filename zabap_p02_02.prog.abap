*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_02
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p02_02.

PARAMETERS:
  pa_v1 TYPE i,
  pa_v2 TYPE i,
  pa_op TYPE c LENGTH 1.

DATA pa_result TYPE p DECIMALS 2.

IF ( pa_op = '+' OR pa_op = '-' OR pa_op = '*' OR pa_op = '/' AND pa_v2 <> 0 ).

  CASE pa_op.
    WHEN '+'.
      pa_result = pa_v1 + pa_v2.
    WHEN '-'.
      pa_result = pa_v1 - pa_v2.
    WHEN '/'.
      pa_result = pa_v1 / pa_v2.
    WHEN '*'.
      pa_result = pa_v1 * pa_v2.
  ENDCASE.

  WRITE: 'Resultado:'(sym),pa_result.

ELSEIF pa_op = '/' AND pa_v2 = 0.
  WRITE 'Resultado:'(syn).
ELSEIF ( pa_op >< '+' OR pa_op >< '-' OR pa_op >< '*' OR pa_op >< '/' ).
  WRITE 'Operador inválido, utilize soma(+), subtração(-), divisão(/), multiplicação(*)'.
ELSE.
  WRITE 'Conta inválida'.
ENDIF.