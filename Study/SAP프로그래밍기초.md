#1. SAP 프로그래밍 기본 
1) INITIALIZATION: 프로그램 실행시 초기값을 세팅할 때 사용
2) AT SELECTION-SCREEN: 프로그램 실행 조건을 체크 (EX: Valiadation check)
3) AT SELECTION-SCREEN OUTPUT: 파라미터 필드를 숨기거나 비활성 시킬때 사용
4) AT SELECTION-SCREEN ON VALUE-REQUEST FOR: 필드에 f4 헬프를 설치
5) START-OF-SELECTION: 프로그램의 본문을 알리는 이벤트 (로직 구현부)
6) END-OF-SELECTION: 프로그램 본문의 종료 (거의 사용 X)

#2. Internal Table
1) 프로그램 내부에서 선언하는 일시적 테이블로서 List 형식의 타입이다. 프로그램 실행시 생성되고 프로그램 종료시에는 사라지는 메모리 테이블
2) 선언방법: DATA: GT_BKPF TYPE TABLE OF BKPF.
3) DB에 존재하는 Transparent table과 동일한 Layout으로 생성

#3. Header line Internal table
1) 인터널 테이블은 대량의 데이터를 담고 있는 메모리 테이블이다. 인터널 테이블에서 데이터를 읽기 위해서는 Line 단위로 한번에 한줄씩 읽어 들여야 한다. 그러기 위해서는 1차원 배열 형식의 메모리가 필요한데 이를 Work area라고 부른다.
2) 헤더라인 인터널 테이블은 Work area를 상단에 탑재하고 있다.
3) 선언방법1: DATA: GT_BKPF TYPE TABLE OF BKPF WITH HEADER LINE.
4) 선언방법2: DATA: BEGIN OF GT_DATA OCCURS 0,
                      BUKRS TYPE BKPF-BUKRS,
                      GJAHR TYPE BKPF-GJAHR,
                      BELNR TYPE BKPF-BELNR,
                      END OF GT_DATA.
5) 방법1은 DB에 존재하는 Transparent table과 동일한 Layout으로 생성
6) 방법2는 개발자가 스스로 정의해서 생성
7) 표현방식  GT_DATA (Work area), GT_DATA[] (Internal table), GT_BKPF도 동일

#4. Work area
1) 1차원 배열의 메모리 구조로서 주로 인터널 테이블의 데이터를 읽기 위해 사용
2) 선언방법1: DATA: GS_BKPF TYPE BKPF.
3) 선언방법2: DATA: BEGIN OF GS_DATA,
                      NAME TYPE BSEG-SGTXT,
                      BELNR TYPE BKPF-BELNR,
                      ADDR1 TYPE ADRC-CITY1,
                      ADDR2 TYPE ADRC-CITY2,
                      END OF GS_DATA.
4) 방법1은 Transparent table과 동일한 Layout으로 생성
5) 방법2는 개발자가 스스로 정의해서 생성

#5. Internal table and Work area
1) Header line Internal table은 Performance가 좋지 않기 때문에 Internal table과 Work area를 분리선언해서 사용하는게 좋다.
2) 방법1: DATA: GT_BKPF TYPE TABLE OF BKPF. (Internal table)
          DATA: GS_BKPF TYPE BKPF. (Work area)
3) 방법2: DATA: BEGIN OF GS_DATA.
                  NAME TYPE BSEG-SGTXT,
                  BELNR TYPE BKPF-BELNR,
                  ADDR1 TYPE ADRC-CITY1,
                  ADDR2 TYPE ADRC-CITY2,
                  END OF GS_DATA.
          DATA: GT_DATA LIKE TABLE OF GS_DATA.
4) 방법2를 보면 Internal table 선언시 TYPE이 아닌 LIKE를 이용했다. TYPE은 DB에 생성된 (SE11에서 생성된) 개체를 참조할때 사용되고 LIKE는 프로그램 내부에 선언된 개체를 참조할때 사용된다.

#6. 일반 변수 선언
1) DATA: GV WAERS TYPE BKPF-WAERS,
         GV OKCODE TYPE SY_UCOMM,
         GV BUDAT TYPE SY-DATUM,
         GV DMBTR TYPE BSEG-DMBTR,
         GV_WRBTR LIKE GV_DMBTR.
2) GV_WRBTR을 보면 LIKE를 사용 했는데 그 이유는 위에 언급한 바와 같다.
