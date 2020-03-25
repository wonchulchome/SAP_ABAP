*&---------------------------------------------------------------------*
*&  Include           ZNOATEST1_TOP
*&---------------------------------------------------------------------*
DATA: OK_CODE TYPE SY-UCOMM.

DATA: go_con TYPE REF TO cl_gui_custom_container,
      go_grid TYPE REF TO cl_gui_alv_grid.

*DATA: itab TYPE table of ZTCFMDD_BD.

TABLES: ZTCFMDD_BD, ZTCFMBDCLASS.

DATA: BEGIN OF ITAB OCCURS 0,
  grdat                 LIKE ZTCFMDD_BD-GRDAT,                    " 날짜
  valuation_area        LIKE ZTCFMDD_BD-Valuation_area,           " 평가영역
  security_id           LIKE ZTCFMDD_BD-SECURITY_ID,              " 종목 ID
  kbnm                  LIKE ZTCFMBDCLASS-kbnm,                   " 종목명
  security_account      LIKE ZTCFMDD_BD-SECURITY_ACCOUNT,         " 유가증권 계정
  nominal_amt           LIKE ZTCFMDD_BD-NOMINAL_AMT,              " 액면
  pos_curr              LIKE ZTCFMDD_BD-POS_CURR,                 " 포지션통화
  val_curr              LIKE ZTCFMDD_BD-VAL_CURR,                 " 평가통화
  book_pos_amt          LIKE ZTCFMDD_BD-BOOK_POS_AMT,             " 장부 외화
  book_val_amt          LIKE ZTCFMDD_BD-BOOK_VAL_AMT,             " 장부 원화
  opcd                  LIKE ZTCFMBDCLASS-OPCD,                   " 옵션 여부
END OF ITAB.

DATA: gt_fieldcat_0100    TYPE lvc_t_fcat,
      gs_fieldcat         TYPE lvc_s_fcat.

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE text-001. "조회 조건

SELECT-OPTIONS:
"날짜
                s_date  FOR ZTCFMDD_BD-grdat OBLIGATORY,
*                         DEFAULT sy-datum OPTION EQ SIGN I
*                         NO INTERVALS NO-EXTENSION,
"종목 ID
                s_secid FOR ZTCFMDD_BD-security_id,
"유가증권 계정
                s_secac FOR ZTCFMDD_BD-security_account.

SELECTION-SCREEN  END  OF  BLOCK  b01.
