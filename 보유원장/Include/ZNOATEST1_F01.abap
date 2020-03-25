*----------------------------------------------------------------------*
***INCLUDE ZNOATEST1_F01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GET_DATA.
*    SELECT * from ztcfmdd_bd left OUTER JOIN ztcfmbdclass
*      on ztcfmdd_bd~SECURITY_ID = ztcfmbdclass~CODE1
*       into CORRESPONDING FIELDS OF TABLE itab[]
*    WHERE ztcfmdd_bd~grdat in s_date.


*  SELECT * from ztcfmdd_bd into CORRESPONDING FIELDS OF TABLE itab[]
*    WHERE grdat in s_date.

SELECT DISTINCT a~grdat, a~valuation_area, a~security_id, b~kbnm, a~security_account,
    a~nominal_amt, a~pos_curr, a~val_curr, a~book_pos_amt, a~book_val_amt, b~opcd
  INTO CORRESPONDING FIELDS OF TABLE @ITAB[]
  FROM ZTCFMDD_BD AS a INNER JOIN ZTCFMBDCLASS AS b
  ON a~security_id = b~code
  WHERE a~grdat IN @s_date
  AND a~security_id IN @s_secid.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  BUILD_FIELDCAT_0100
*&---------------------------------------------------------------------*
FORM build_fieldcat_0100 .
  DATA: ls_fcat             TYPE slis_fieldcat_alv,
        lt_fcat             TYPE slis_t_fieldcat_alv.

  CLEAR: lt_fcat[], gt_fieldcat_0100[].

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-repid
      i_internal_tabname     = 'ITAB'
      i_inclname             = sy-repid
    CHANGING
      ct_fieldcat            = lt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  LOOP AT lt_fcat  INTO ls_fcat.
    CLEAR: gs_fieldcat.
    MOVE-CORRESPONDING ls_fcat  TO gs_fieldcat.

    CASE gs_fieldcat-fieldname.

      WHEN 'GRDAT'.
        gs_fieldcat-REPTEXT = '날짜'.
        gs_fieldcat-outputlen = '8'.
        ls_fcat-seltext_l = '날짜'.
      WHEN 'VALUATION_AREA'.
        gs_fieldcat-REPTEXT = '평가영역'.
        gs_fieldcat-outputlen = '3'.
        ls_fcat-seltext_l = '평가영역'.
      WHEN 'SECURITY_ID'.
        gs_fieldcat-REPTEXT = '종목 ID'.
        gs_fieldcat-outputlen = '13'.
        ls_fcat-seltext_l = '종목 ID'.
      WHEN 'KBNM'.
        gs_fieldcat-REPTEXT = '종목명'.
        gs_fieldcat-outputlen = '50'.
        ls_fcat-seltext_l = '종목명'.
      WHEN 'SECURITY_ACCOUNT'.
        gs_fieldcat-REPTEXT = '유가증권 계정'.
        gs_fieldcat-outputlen = '10'.
        ls_fcat-seltext_l = '유가증권 계정'.
      WHEN 'NOMINAL_AMT'.
        gs_fieldcat-REPTEXT = '액면'.
        gs_fieldcat-outputlen = '21'.
        ls_fcat-seltext_l = '액면'.
      WHEN 'POS_CURR'.
        gs_fieldcat-REPTEXT = '포지션 통화'.
        gs_fieldcat-outputlen = '5'.
        ls_fcat-seltext_l = '포지션 통화'.
      WHEN 'VAL_CURR'.
        gs_fieldcat-REPTEXT = '평가통화'.
        gs_fieldcat-outputlen = '5'.
        ls_fcat-seltext_l = '평가통화'.
      WHEN 'BOOK_POS_AMT'.
        gs_fieldcat-REPTEXT = '장부 외화'.
        gs_fieldcat-outputlen = '21'.
        ls_fcat-seltext_l = '장부 외화'.
      WHEN 'BOOK_VAL_AMT'.
        gs_fieldcat-REPTEXT = '장부 원화'.
        gs_fieldcat-outputlen = '21'.
        ls_fcat-seltext_l = '장부 원화'.
      WHEN 'OPCD'.
        gs_fieldcat-REPTEXT = '옵션 여부'.
        gs_fieldcat-outputlen = '10'.
        ls_fcat-seltext_l = '옵션 여부'.
*      WHEN OTHERS.
*        DELETE lt_fcat INDEX sy-tabix.
*        CONTINUE.

    ENDCASE.

    APPEND gs_fieldcat  TO gt_fieldcat_0100.
  ENDLOOP.

ENDFORM.                    " BUILD_FIELDCAT_0100
