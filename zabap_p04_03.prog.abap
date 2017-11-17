*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZABAP_P04_03.

PARAMETERS: pa_v1 type i,
            pa_v2 type i,
            pa_op type c LENGTH 1.


data result type p length 4 decimals 2.

case pa_op.
   when '*'.
     result = pa_v1 * pa_v2.
   when '/'.
     if pa_v2 = 0.
       MESSAGE i002(ZMSG) with sy-uname pa_v2. "mensagem divisão por 0
     else.
       result = pa_v1 / pa_v2.
     endif.
     exit.
   when '+'.
     result = pa_v1 + pa_v2.
   when '-'.
     result = pa_v1 - pa_v2.

   when '%'.
     PERFORM calcperc
      USING pa_v1
            pa_v2
      CHANGING result.
   when others.
     MESSAGE i001(ZMSG) with pa_op. "mensagem de operador inválido
 endcase.

Write: 'o resultado é:', result.

*&---------------------------------------------------------------------*
*&      Form  CALCPERC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_PA_V1  text
*      -->P_PA_V2  text
*      <--P_RESULT  text
*----------------------------------------------------------------------*
form CALCPERC  using    p_pa_v1 LIKE pa_v1
                        p_pa_v2 LIKE pa_v2
               changing p_result LIKE result.

  p_result = p_pa_v2 / 100 * p_pa_v1.

endform.                    " CALCPERC