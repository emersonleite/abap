*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p02_00.

DATA var_res TYPE p DECIMALS 2.
PARAMETERS: pa_v1 TYPE i, pa_v2 TYPE i, pa_op TYPE c.

CASE pa_op.
  WHEN '+'.
    var_res = pa_v1 + pa_v2.
  WHEN '-'.
    var_res = pa_v1 - pa_v2.
  WHEN '*'.
    var_res = pa_v1 * pa_v2.
  WHEN '/'.
    IF pa_v2 = 0.
      WRITE 'Não é possível dividir por zero!!'.
      EXIT.
    ELSE.
      var_res = pa_v1 / pa_v2.
    ENDIF.

  WHEN OTHERS.
    WRITE 'Operador INVÁLIDO!!'.
    EXIT.
ENDCASE.

IF pa_v2 <> 0.
  WRITE: 'O Resultado é:     ', var_res.
ENDIF.