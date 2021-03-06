*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZABAP_P02_03.

PARAMETERS: pa_v1 type i,
            pa_v2 type i,
            pa_op type c LENGTH 1.


data result type p length 4 decimals 2.

case pa_op.
   when '*'.
     result = pa_v1 * pa_v2.
   when '/'.
     if pa_v2 = 0.
       Write 'Não permitda divisão por 0'.
     else.
       result = pa_v1 / pa_v2.
     endif.
     exit.
   when '+'.
     result = pa_v1 + pa_v2.
   when '-'.
     result = pa_v1 - pa_v2.
   when others.
     write 'entre com *, /, + ou -'.
 endcase.

Write: 'o resultado é:', result.