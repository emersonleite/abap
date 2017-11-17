*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p05_00.

DATA var_res TYPE bc400_perc.
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
*      WRITE 'Não é possível dividir por zero!!'.
      MESSAGE i002(zmsg) WITH sy-uname.
      EXIT.
    ELSE.
      var_res = pa_v1 / pa_v2.
    ENDIF.
  WHEN '%'.
    PERFORM calc_perc
    USING
          pa_v1
          pa_v2
    CHANGING
          var_res.
  WHEN 'E'.
    CALL FUNCTION 'Z_CALC_EXPO_00'
      EXPORTING
        im_v1                     = pa_v1
        im_v2                     = pa_v2
      IMPORTING
        ex_resultado              = var_res
      EXCEPTIONS
        expo_maior_que_quatro     = 5
        exponencial_nao_informado = 6
        valor_nao_informado       = 7
        OTHERS                    = 4.
    IF sy-subrc <> 0.
      MESSAGE i004(zmsg) WITH sy-subrc.
      EXIT.
    ENDIF.

  WHEN OTHERS.
*   WRITE 'Operador INVÁLIDO!!'.
    MESSAGE i001(zmsg) WITH pa_op.
    EXIT.
ENDCASE.


WRITE: 'O Resultado é:     ', var_res.
MESSAGE s003(zmsg) WITH var_res.
*&---------------------------------------------------------------------*
*&      Form  CALC_PERC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_PA_V1  text
*      -->P_PA_V2  text
*      <--P_VAR_RES  text
*----------------------------------------------------------------------*
FORM calc_perc  USING
                      value(pvar_op1) TYPE i
                      value(pvar_op2) TYPE i
                CHANGING
                      value(pvar_res) LIKE var_res.

  pvar_res = pvar_op2 / 100 * pvar_op1.

ENDFORM.                    " CALC_PERC