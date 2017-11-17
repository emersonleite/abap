*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p05_05.

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
    CALL FUNCTION 'Z_CALC_EXPO_05'
      EXPORTING
        im_v1                = pa_v1
        im_v2                = pa_v2
      IMPORTING
        ex_resu              = var_res
      EXCEPTIONS
        exp_maior_que_quatro = 1
        exp_nao_informado    = 2
        vlr_nao_informado    = 3
        OTHERS               = 4.
    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN '1'.
          MESSAGE i005(zmsg) WITH sy-subrc.
          EXIT.
        WHEN '2'.
          MESSAGE i006(zmsg) WITH sy-subrc.
          EXIT.
        WHEN '3'.
          MESSAGE i007(zmsg) WITH sy-subrc.
          EXIT.
        WHEN OTHERS.
          MESSAGE i008(zmsg) WITH sy-subrc.
          EXIT.
      ENDCASE.
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