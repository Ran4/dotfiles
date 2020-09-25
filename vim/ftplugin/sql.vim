" Vim syntax file
" Language:	SQL, PLPGSQL (PostgreSQL)
" Maintainer:	Devdas Bhagat <devdas@dvb.homelinux.org>
" Derived from the syntax file for plsql maintained by
" Paul Moore <gustav@morpheus.demon.co.uk>
" Last Change:	2004 April 17
" Version: 0.04
"

" BEGIN MODIFIED BY RAN
"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim
" END MODIFIED BY RAN

set expandtab
set tabstop=4

set colorcolumn=120

nnoremap äq maI--<esc>`a2l
nnoremap äQ ma^xx`a2h

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" The SQL reserved words, defined as keywords.

syn keyword psqlSpecial  false null true

syn keyword psqlKeyword	access add as asc begin by case check cluster column
syn keyword psqlKeyword	compress connect current cursor decimal default desc
syn keyword psqlKeyword	else elsif end exception exclusive file for from
syn keyword psqlKeyword	function group having identified if immediate increment
syn keyword psqlKeyword	index initial into is level loop maxextents mode modify
syn keyword psqlKeyword	nocompress nowait of offline on online start
syn keyword psqlKeyword	successful synonym table then to trigger uid
syn keyword psqlKeyword	unique user validate values view whenever
syn keyword psqlKeyword	where with option order privileges procedural
syn keyword psqlKeyword	public resource return row rowlabel rownum rows
syn keyword psqlKeyword	session share size type using close open
syn keyword psqlKeyword	declare constraint join temporary sequence
syn keyword psqlKeyword	inner outer cross natural full left right
syn keyword psqlKeyword	language handler trusted untrusted validator

syn keyword psqlOperator	not and or primary key
syn keyword psqlOperator	in any some all between exists
syn keyword psqlOperator	ilike like escape cast
syn keyword psqlOperator 	union intersect minus
syn keyword psqlOperator 	prior distinct references

syn match  psqlOperator 	"\(+\|%\|-\|=\|\/\|!\|!!\|!!=\|!\~\|!\~\*\)"
syn match  psqlOperator 	"\(!\~\~\|!\~\~\*\|#\|##\|#<\|#<>\|?||\)"
syn match  psqlOperator 	"\(#<=\|#=\|#>\|#>=\|&\|&&\|&<\|&>\|?|\)"
syn match  psqlOperator 	"\(\*\|>\|<\|<=\|>=\|<->\|<<\|>>\|?-|\)"
syn match  psqlOperator 	"\(<<=\|<>\|<^\|>^\|>>=\|?#\|?-\|@\)"
syn match  psqlOperator 	"\(@@\|@-@\|^\||\|||\|||\/\|\~\|\~\*\)"
syn match  psqlOperator 	"\(\~=\|\~\~\|\~\~\*\|:=\)"

syn keyword psqlStatement alter analyze audit comment commit create
syn keyword psqlStatement delete drop execute explain grant insert lock 
syn keyword psqlStatement rename revoke rollback savepoint select set
syn keyword psqlStatement truncate update analyze vacuum replace

syn keyword psqlType	boolean char character date float integer long
syn keyword psqlType	mlslabel number raw rowid varchar varchar2 varray
syn keyword psqlType	int int4 int8 float4 float8 line interval lseq
syn keyword psqlType	smallint bigint serial bigserial inet cidr macaddr
syn keyword psqlType	bit varbit bool box bytea circle numeric decimal 
syn keyword psqlType	path point polygon text time timetz timestamp 
syn keyword psqlType	timestamptz real name int2vector regproc 
syn keyword psqlType	oid tid xid cid oidvector smgr lseg double
syn keyword psqlType	abstime reltime tinterval aclitem void opaque
syn keyword psqlType	refcursor regprocedure regoper regoperator regclass
syn keyword psqlType	regtype record cstring anyarray array
syn keyword psqlType	language_handler

syn keyword psqlAggregate avg count max min stddev sum variance

" Strings and characters:
syn region psqlString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region psqlString		start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers:
syn match psqlNumber		"-\=\<\d*\.\=[0-9_]\>"

" Comments:
syn region psqlComment    start="/\*"  end="\*/"
syn match psqlComment	"--.*"

syn sync ccomment psqlComment

syn region psqlFunction    start="abbrev(" end=")" contains=ALL
syn region psqlFunction    start="abs(" end=")" contains=ALL
syn region psqlFunction    start="abstime(" end=")" contains=ALL
syn region psqlFunction    start="abstimeeq(" end=")" contains=ALL
syn region psqlFunction    start="abstimege(" end=")" contains=ALL
syn region psqlFunction    start="abstimegt(" end=")" contains=ALL
syn region psqlFunction    start="abstimele(" end=")" contains=ALL
syn region psqlFunction    start="abstimelt(" end=")" contains=ALL
syn region psqlFunction    start="abstimene(" end=")" contains=ALL
syn region psqlFunction    start="aclcontains(" end=")" contains=ALL
syn region psqlFunction    start="aclinsert(" end=")" contains=ALL
syn region psqlFunction    start="aclremove(" end=")" contains=ALL
syn region psqlFunction    start="acos(" end=")" contains=ALL
syn region psqlFunction    start="age(" end=")" contains=ALL
syn region psqlFunction    start="alt_to_iso(" end=")" contains=ALL
syn region psqlFunction    start="alt_to_koi8r(" end=")" contains=ALL
syn region psqlFunction    start="alt_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="alt_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="alt_to_win1251(" end=")" contains=ALL
syn region psqlFunction    start="area(" end=")" contains=ALL
syn region psqlFunction    start="areajoinsel(" end=")" contains=ALL
syn region psqlFunction    start="areasel(" end=")" contains=ALL
syn region psqlFunction    start="array_dims(" end=")" contains=ALL
syn region psqlFunction    start="array_eq(" end=")" contains=ALL
syn region psqlFunction    start="array_length_coerce(" end=")" contains=ALL
syn region psqlFunction    start="ascii(" end=")" contains=ALL
syn region psqlFunction    start="ascii_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="ascii_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="asin(" end=")" contains=ALL
syn region psqlFunction    start="atan2(" end=")" contains=ALL
syn region psqlFunction    start="atan(" end=")" contains=ALL
syn region psqlFunction    start="big5_to_euc_tw(" end=")" contains=ALL
syn region psqlFunction    start="big5_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="big5_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="bitand(" end=")" contains=ALL
syn region psqlFunction    start="bitcat(" end=")" contains=ALL
syn region psqlFunction    start="bitcmp(" end=")" contains=ALL
syn region psqlFunction    start="bit(" end=")" contains=ALL
syn region psqlFunction    start="biteq(" end=")" contains=ALL
syn region psqlFunction    start="bitge(" end=")" contains=ALL
syn region psqlFunction    start="bitgt(" end=")" contains=ALL
syn region psqlFunction    start="bitle(" end=")" contains=ALL
syn region psqlFunction    start="bit_length(" end=")" contains=ALL
syn region psqlFunction    start="bitlt(" end=")" contains=ALL
syn region psqlFunction    start="bitne(" end=")" contains=ALL
syn region psqlFunction    start="bitnot(" end=")" contains=ALL
syn region psqlFunction    start="bitor(" end=")" contains=ALL
syn region psqlFunction    start="bitshiftleft(" end=")" contains=ALL
syn region psqlFunction    start="bitshiftright(" end=")" contains=ALL
syn region psqlFunction    start="bitxor(" end=")" contains=ALL
syn region psqlFunction    start="booleq(" end=")" contains=ALL
syn region psqlFunction    start="boolge(" end=")" contains=ALL
syn region psqlFunction    start="boolgt(" end=")" contains=ALL
syn region psqlFunction    start="boolle(" end=")" contains=ALL
syn region psqlFunction    start="boollt(" end=")" contains=ALL
syn region psqlFunction    start="boolne(" end=")" contains=ALL
syn region psqlFunction    start="box_above(" end=")" contains=ALL
syn region psqlFunction    start="box_add(" end=")" contains=ALL
syn region psqlFunction    start="box_below(" end=")" contains=ALL
syn region psqlFunction    start="box_center(" end=")" contains=ALL
syn region psqlFunction    start="box_contained(" end=")" contains=ALL
syn region psqlFunction    start="box_contain(" end=")" contains=ALL
syn region psqlFunction    start="box_distance(" end=")" contains=ALL
syn region psqlFunction    start="box_div(" end=")" contains=ALL
syn region psqlFunction    start="box(" end=")" contains=ALL
syn region psqlFunction    start="box_eq(" end=")" contains=ALL
syn region psqlFunction    start="box_ge(" end=")" contains=ALL
syn region psqlFunction    start="box_gt(" end=")" contains=ALL
syn region psqlFunction    start="box_intersect(" end=")" contains=ALL
syn region psqlFunction    start="box_le(" end=")" contains=ALL
syn region psqlFunction    start="box_left(" end=")" contains=ALL
syn region psqlFunction    start="box_lt(" end=")" contains=ALL
syn region psqlFunction    start="box_mul(" end=")" contains=ALL
syn region psqlFunction    start="box_overlap(" end=")" contains=ALL
syn region psqlFunction    start="box_overleft(" end=")" contains=ALL
syn region psqlFunction    start="box_overright(" end=")" contains=ALL
syn region psqlFunction    start="box_right(" end=")" contains=ALL
syn region psqlFunction    start="box_same(" end=")" contains=ALL
syn region psqlFunction    start="box_sub(" end=")" contains=ALL
syn region psqlFunction    start="bpcharcmp(" end=")" contains=ALL
syn region psqlFunction    start="bpchar(" end=")" contains=ALL
syn region psqlFunction    start="bpchareq(" end=")" contains=ALL
syn region psqlFunction    start="bpcharge(" end=")" contains=ALL
syn region psqlFunction    start="bpchargt(" end=")" contains=ALL
syn region psqlFunction    start="bpcharle(" end=")" contains=ALL
syn region psqlFunction    start="bpcharlt(" end=")" contains=ALL
syn region psqlFunction    start="bpcharne(" end=")" contains=ALL
syn region psqlFunction    start="broadcast(" end=")" contains=ALL
syn region psqlFunction    start="btabstimecmp(" end=")" contains=ALL
syn region psqlFunction    start="btbeginscan(" end=")" contains=ALL
syn region psqlFunction    start="btboolcmp(" end=")" contains=ALL
syn region psqlFunction    start="btbuild(" end=")" contains=ALL
syn region psqlFunction    start="btbulkdelete(" end=")" contains=ALL
syn region psqlFunction    start="btcharcmp(" end=")" contains=ALL
syn region psqlFunction    start="btcostestimate(" end=")" contains=ALL
syn region psqlFunction    start="btendscan(" end=")" contains=ALL
syn region psqlFunction    start="btfloat4cmp(" end=")" contains=ALL
syn region psqlFunction    start="btfloat8cmp(" end=")" contains=ALL
syn region psqlFunction    start="btgettuple(" end=")" contains=ALL
syn region psqlFunction    start="btinsert(" end=")" contains=ALL
syn region psqlFunction    start="btint2cmp(" end=")" contains=ALL
syn region psqlFunction    start="btint4cmp(" end=")" contains=ALL
syn region psqlFunction    start="btint8cmp(" end=")" contains=ALL
syn region psqlFunction    start="btmarkpos(" end=")" contains=ALL
syn region psqlFunction    start="btnamecmp(" end=")" contains=ALL
syn region psqlFunction    start="btoidcmp(" end=")" contains=ALL
syn region psqlFunction    start="btoidvectorcmp(" end=")" contains=ALL
syn region psqlFunction    start="btrescan(" end=")" contains=ALL
syn region psqlFunction    start="btrestrpos(" end=")" contains=ALL
syn region psqlFunction    start="btrim(" end=")" contains=ALL
syn region psqlFunction    start="bttextcmp(" end=")" contains=ALL
syn region psqlFunction    start="byteacat(" end=")" contains=ALL
syn region psqlFunction    start="byteacmp(" end=")" contains=ALL
syn region psqlFunction    start="byteaeq(" end=")" contains=ALL
syn region psqlFunction    start="byteage(" end=")" contains=ALL
syn region psqlFunction    start="byteagt(" end=")" contains=ALL
syn region psqlFunction    start="byteale(" end=")" contains=ALL
syn region psqlFunction    start="bytealike(" end=")" contains=ALL
syn region psqlFunction    start="bytealt(" end=")" contains=ALL
syn region psqlFunction    start="byteane(" end=")" contains=ALL
syn region psqlFunction    start="byteanlike(" end=")" contains=ALL
syn region psqlFunction    start="cash_div_flt4(" end=")" contains=ALL
syn region psqlFunction    start="cash_div_flt8(" end=")" contains=ALL
syn region psqlFunction    start="cash_div_int2(" end=")" contains=ALL
syn region psqlFunction    start="cash_div_int4(" end=")" contains=ALL
syn region psqlFunction    start="cash_eq(" end=")" contains=ALL
syn region psqlFunction    start="cash_ge(" end=")" contains=ALL
syn region psqlFunction    start="cash_gt(" end=")" contains=ALL
syn region psqlFunction    start="cashlarger(" end=")" contains=ALL
syn region psqlFunction    start="cash_le(" end=")" contains=ALL
syn region psqlFunction    start="cash_lt(" end=")" contains=ALL
syn region psqlFunction    start="cash_mi(" end=")" contains=ALL
syn region psqlFunction    start="cash_mul_flt4(" end=")" contains=ALL
syn region psqlFunction    start="cash_mul_flt8(" end=")" contains=ALL
syn region psqlFunction    start="cash_mul_int2(" end=")" contains=ALL
syn region psqlFunction    start="cash_mul_int4(" end=")" contains=ALL
syn region psqlFunction    start="cash_ne(" end=")" contains=ALL
syn region psqlFunction    start="cash_pl(" end=")" contains=ALL
syn region psqlFunction    start="cashsmaller(" end=")" contains=ALL
syn region psqlFunction    start="cash_words(" end=")" contains=ALL
syn region psqlFunction    start="cbrt(" end=")" contains=ALL
syn region psqlFunction    start="ceil(" end=")" contains=ALL
syn region psqlFunction    start="center(" end=")" contains=ALL
syn region psqlFunction    start="character_length(" end=")" contains=ALL
syn region psqlFunction    start="chardiv(" end=")" contains=ALL
syn region psqlFunction    start="char(" end=")" contains=ALL
syn region psqlFunction    start="chareq(" end=")" contains=ALL
syn region psqlFunction    start="charge(" end=")" contains=ALL
syn region psqlFunction    start="chargt(" end=")" contains=ALL
syn region psqlFunction    start="charle(" end=")" contains=ALL
syn region psqlFunction    start="char_length(" end=")" contains=ALL
syn region psqlFunction    start="charlt(" end=")" contains=ALL
syn region psqlFunction    start="charmi(" end=")" contains=ALL
syn region psqlFunction    start="charmul(" end=")" contains=ALL
syn region psqlFunction    start="charne(" end=")" contains=ALL
syn region psqlFunction    start="charpl(" end=")" contains=ALL
syn region psqlFunction    start="chr(" end=")" contains=ALL
syn region psqlFunction    start="cideq(" end=")" contains=ALL
syn region psqlFunction    start="cidr(" end=")" contains=ALL
syn region psqlFunction    start="circle_above(" end=")" contains=ALL
syn region psqlFunction    start="circle_add_pt(" end=")" contains=ALL
syn region psqlFunction    start="circle_below(" end=")" contains=ALL
syn region psqlFunction    start="circle_center(" end=")" contains=ALL
syn region psqlFunction    start="circle_contained(" end=")" contains=ALL
syn region psqlFunction    start="circle_contain(" end=")" contains=ALL
syn region psqlFunction    start="circle_contain_pt(" end=")" contains=ALL
syn region psqlFunction    start="circle_distance(" end=")" contains=ALL
syn region psqlFunction    start="circle_div_pt(" end=")" contains=ALL
syn region psqlFunction    start="circle(" end=")" contains=ALL
syn region psqlFunction    start="circle_eq(" end=")" contains=ALL
syn region psqlFunction    start="circle_ge(" end=")" contains=ALL
syn region psqlFunction    start="circle_gt(" end=")" contains=ALL
syn region psqlFunction    start="circle_le(" end=")" contains=ALL
syn region psqlFunction    start="circle_left(" end=")" contains=ALL
syn region psqlFunction    start="circle_lt(" end=")" contains=ALL
syn region psqlFunction    start="circle_mul_pt(" end=")" contains=ALL
syn region psqlFunction    start="circle_ne(" end=")" contains=ALL
syn region psqlFunction    start="circle_overlap(" end=")" contains=ALL
syn region psqlFunction    start="circle_overleft(" end=")" contains=ALL
syn region psqlFunction    start="circle_overright(" end=")" contains=ALL
syn region psqlFunction    start="circle_right(" end=")" contains=ALL
syn region psqlFunction    start="circle_same(" end=")" contains=ALL
syn region psqlFunction    start="circle_sub_pt(" end=")" contains=ALL
syn region psqlFunction    start="close_lb(" end=")" contains=ALL
syn region psqlFunction    start="close_lseg(" end=")" contains=ALL
syn region psqlFunction    start="close_ls(" end=")" contains=ALL
syn region psqlFunction    start="close_pb(" end=")" contains=ALL
syn region psqlFunction    start="close_pl(" end=")" contains=ALL
syn region psqlFunction    start="close_ps(" end=")" contains=ALL
syn region psqlFunction    start="close_sb(" end=")" contains=ALL
syn region psqlFunction    start="close_sl(" end=")" contains=ALL
syn region psqlFunction    start="col_description(" end=")" contains=ALL
syn region psqlFunction    start="contjoinsel(" end=")" contains=ALL
syn region psqlFunction    start="contsel(" end=")" contains=ALL
syn region psqlFunction    start="convert(" end=")" contains=ALL
syn region psqlFunction    start="convert_using(" end=")" contains=ALL
syn region psqlFunction    start="cos(" end=")" contains=ALL
syn region psqlFunction    start="cot(" end=")" contains=ALL
syn region psqlFunction    start="current_database(" end=")" contains=ALL
syn region psqlFunction    start="current_schema(" end=")" contains=ALL
syn region psqlFunction    start="current_schemas(" end=")" contains=ALL
syn region psqlFunction    start="current_setting(" end=")" contains=ALL
syn region psqlFunction    start="current_user(" end=")" contains=ALL
syn region psqlFunction    start="currtid2(" end=")" contains=ALL
syn region psqlFunction    start="currtid(" end=")" contains=ALL
syn region psqlFunction    start="currval(" end=")" contains=ALL
syn region psqlFunction    start="date_cmp(" end=")" contains=ALL
syn region psqlFunction    start="date(" end=")" contains=ALL
syn region psqlFunction    start="date_eq(" end=")" contains=ALL
syn region psqlFunction    start="date_ge(" end=")" contains=ALL
syn region psqlFunction    start="date_gt(" end=")" contains=ALL
syn region psqlFunction    start="date_larger(" end=")" contains=ALL
syn region psqlFunction    start="date_le(" end=")" contains=ALL
syn region psqlFunction    start="date_lt(" end=")" contains=ALL
syn region psqlFunction    start="date_mi(" end=")" contains=ALL
syn region psqlFunction    start="date_mii(" end=")" contains=ALL
syn region psqlFunction    start="date_mi_interval(" end=")" contains=ALL
syn region psqlFunction    start="date_ne(" end=")" contains=ALL
syn region psqlFunction    start="date_part(" end=")" contains=ALL
syn region psqlFunction    start="date_pli(" end=")" contains=ALL
syn region psqlFunction    start="date_pl_interval(" end=")" contains=ALL
syn region psqlFunction    start="date_smaller(" end=")" contains=ALL
syn region psqlFunction    start="datetime_pl(" end=")" contains=ALL
syn region psqlFunction    start="datetimetz_pl(" end=")" contains=ALL
syn region psqlFunction    start="date_trunc(" end=")" contains=ALL
syn region psqlFunction    start="dcbrt(" end=")" contains=ALL
syn region psqlFunction    start="decode(" end=")" contains=ALL
syn region psqlFunction    start="degrees(" end=")" contains=ALL
syn region psqlFunction    start="dexp(" end=")" contains=ALL
syn region psqlFunction    start="diagonal(" end=")" contains=ALL
syn region psqlFunction    start="diameter(" end=")" contains=ALL
syn region psqlFunction    start="dist_cpoly(" end=")" contains=ALL
syn region psqlFunction    start="dist_lb(" end=")" contains=ALL
syn region psqlFunction    start="dist_pb(" end=")" contains=ALL
syn region psqlFunction    start="dist_pc(" end=")" contains=ALL
syn region psqlFunction    start="dist_pl(" end=")" contains=ALL
syn region psqlFunction    start="dist_ppath(" end=")" contains=ALL
syn region psqlFunction    start="dist_ps(" end=")" contains=ALL
syn region psqlFunction    start="dist_sb(" end=")" contains=ALL
syn region psqlFunction    start="dist_sl(" end=")" contains=ALL
syn region psqlFunction    start="dlog10(" end=")" contains=ALL
syn region psqlFunction    start="dlog1(" end=")" contains=ALL
syn region psqlFunction    start="dpow(" end=")" contains=ALL
syn region psqlFunction    start="dround(" end=")" contains=ALL
syn region psqlFunction    start="dsqrt(" end=")" contains=ALL
syn region psqlFunction    start="dtrunc(" end=")" contains=ALL
syn region psqlFunction    start="encode(" end=")" contains=ALL
syn region psqlFunction    start="eqjoinsel(" end=")" contains=ALL
syn region psqlFunction    start="eqsel(" end=")" contains=ALL
syn region psqlFunction    start="euc_cn_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="euc_cn_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="euc_jp_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="euc_jp_to_sjis(" end=")" contains=ALL
syn region psqlFunction    start="euc_jp_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="euc_kr_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="euc_kr_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="euc_tw_to_big5(" end=")" contains=ALL
syn region psqlFunction    start="euc_tw_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="euc_tw_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="exp(" end=")" contains=ALL
syn region psqlFunction    start="factorial(" end=")" contains=ALL
syn region psqlFunction    start="float48div(" end=")" contains=ALL
syn region psqlFunction    start="float48eq(" end=")" contains=ALL
syn region psqlFunction    start="float48ge(" end=")" contains=ALL
syn region psqlFunction    start="float48gt(" end=")" contains=ALL
syn region psqlFunction    start="float48le(" end=")" contains=ALL
syn region psqlFunction    start="float48lt(" end=")" contains=ALL
syn region psqlFunction    start="float48mi(" end=")" contains=ALL
syn region psqlFunction    start="float48mul(" end=")" contains=ALL
syn region psqlFunction    start="float48ne(" end=")" contains=ALL
syn region psqlFunction    start="float48pl(" end=")" contains=ALL
syn region psqlFunction    start="float4abs(" end=")" contains=ALL
syn region psqlFunction    start="float4_accum(" end=")" contains=ALL
syn region psqlFunction    start="float4div(" end=")" contains=ALL
syn region psqlFunction    start="float4(" end=")" contains=ALL
syn region psqlFunction    start="float4eq(" end=")" contains=ALL
syn region psqlFunction    start="float4ge(" end=")" contains=ALL
syn region psqlFunction    start="float4gt(" end=")" contains=ALL
syn region psqlFunction    start="float4larger(" end=")" contains=ALL
syn region psqlFunction    start="float4le(" end=")" contains=ALL
syn region psqlFunction    start="float4lt(" end=")" contains=ALL
syn region psqlFunction    start="float4mi(" end=")" contains=ALL
syn region psqlFunction    start="float4mul(" end=")" contains=ALL
syn region psqlFunction    start="float4ne(" end=")" contains=ALL
syn region psqlFunction    start="float4pl(" end=")" contains=ALL
syn region psqlFunction    start="float4smaller(" end=")" contains=ALL
syn region psqlFunction    start="float4um(" end=")" contains=ALL
syn region psqlFunction    start="float4up(" end=")" contains=ALL
syn region psqlFunction    start="float84div(" end=")" contains=ALL
syn region psqlFunction    start="float84eq(" end=")" contains=ALL
syn region psqlFunction    start="float84ge(" end=")" contains=ALL
syn region psqlFunction    start="float84gt(" end=")" contains=ALL
syn region psqlFunction    start="float84le(" end=")" contains=ALL
syn region psqlFunction    start="float84lt(" end=")" contains=ALL
syn region psqlFunction    start="float84mi(" end=")" contains=ALL
syn region psqlFunction    start="float84mul(" end=")" contains=ALL
syn region psqlFunction    start="float84ne(" end=")" contains=ALL
syn region psqlFunction    start="float84pl(" end=")" contains=ALL
syn region psqlFunction    start="float8abs(" end=")" contains=ALL
syn region psqlFunction    start="float8_accum(" end=")" contains=ALL
syn region psqlFunction    start="float8_avg(" end=")" contains=ALL
syn region psqlFunction    start="float8div(" end=")" contains=ALL
syn region psqlFunction    start="float8(" end=")" contains=ALL
syn region psqlFunction    start="float8eq(" end=")" contains=ALL
syn region psqlFunction    start="float8ge(" end=")" contains=ALL
syn region psqlFunction    start="float8gt(" end=")" contains=ALL
syn region psqlFunction    start="float8larger(" end=")" contains=ALL
syn region psqlFunction    start="float8le(" end=")" contains=ALL
syn region psqlFunction    start="float8lt(" end=")" contains=ALL
syn region psqlFunction    start="float8mi(" end=")" contains=ALL
syn region psqlFunction    start="float8mul(" end=")" contains=ALL
syn region psqlFunction    start="float8ne(" end=")" contains=ALL
syn region psqlFunction    start="float8pl(" end=")" contains=ALL
syn region psqlFunction    start="float8smaller(" end=")" contains=ALL
syn region psqlFunction    start="float8_stddev(" end=")" contains=ALL
syn region psqlFunction    start="float8um(" end=")" contains=ALL
syn region psqlFunction    start="float8up(" end=")" contains=ALL
syn region psqlFunction    start="float8_variance(" end=")" contains=ALL
syn region psqlFunction    start="floor(" end=")" contains=ALL
syn region psqlFunction    start="flt4_mul_cash(" end=")" contains=ALL
syn region psqlFunction    start="flt8_mul_cash(" end=")" contains=ALL
syn region psqlFunction    start="fmgr_c_validator(" end=")" contains=ALL
syn region psqlFunction    start="fmgr_internal_validator(" end=")" contains=ALL
syn region psqlFunction    start="fmgr_sql_validator(" end=")" contains=ALL
syn region psqlFunction    start="format_type(" end=")" contains=ALL
syn region psqlFunction    start="gb18030_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="gbk_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="get_bit(" end=")" contains=ALL
syn region psqlFunction    start="get_byte(" end=")" contains=ALL
syn region psqlFunction    start="getdatabaseencoding(" end=")" contains=ALL
syn region psqlFunction    start="getpgusername(" end=")" contains=ALL
syn region psqlFunction    start="gistbeginscan(" end=")" contains=ALL
syn region psqlFunction    start="gistbuild(" end=")" contains=ALL
syn region psqlFunction    start="gistbulkdelete(" end=")" contains=ALL
syn region psqlFunction    start="gistcostestimate(" end=")" contains=ALL
syn region psqlFunction    start="gistendscan(" end=")" contains=ALL
syn region psqlFunction    start="gistgettuple(" end=")" contains=ALL
syn region psqlFunction    start="gistinsert(" end=")" contains=ALL
syn region psqlFunction    start="gistmarkpos(" end=")" contains=ALL
syn region psqlFunction    start="gistrescan(" end=")" contains=ALL
syn region psqlFunction    start="gistrestrpos(" end=")" contains=ALL
syn region psqlFunction    start="has_database_privilege(" end=")" contains=ALL
syn region psqlFunction    start="has_function_privilege(" end=")" contains=ALL
syn region psqlFunction    start="hashbeginscan(" end=")" contains=ALL
syn region psqlFunction    start="hashbpchar(" end=")" contains=ALL
syn region psqlFunction    start="hashbuild(" end=")" contains=ALL
syn region psqlFunction    start="hashbulkdelete(" end=")" contains=ALL
syn region psqlFunction    start="hashchar(" end=")" contains=ALL
syn region psqlFunction    start="hashcostestimate(" end=")" contains=ALL
syn region psqlFunction    start="hashendscan(" end=")" contains=ALL
syn region psqlFunction    start="hashfloat4(" end=")" contains=ALL
syn region psqlFunction    start="hashfloat8(" end=")" contains=ALL
syn region psqlFunction    start="hashgettuple(" end=")" contains=ALL
syn region psqlFunction    start="hashinsert(" end=")" contains=ALL
syn region psqlFunction    start="hashint2(" end=")" contains=ALL
syn region psqlFunction    start="hashint4(" end=")" contains=ALL
syn region psqlFunction    start="hashint8(" end=")" contains=ALL
syn region psqlFunction    start="hashmacaddr(" end=")" contains=ALL
syn region psqlFunction    start="hashmarkpos(" end=")" contains=ALL
syn region psqlFunction    start="hashname(" end=")" contains=ALL
syn region psqlFunction    start="hashoid(" end=")" contains=ALL
syn region psqlFunction    start="hashoidvector(" end=")" contains=ALL
syn region psqlFunction    start="hashrescan(" end=")" contains=ALL
syn region psqlFunction    start="hashrestrpos(" end=")" contains=ALL
syn region psqlFunction    start="hashvarlena(" end=")" contains=ALL
syn region psqlFunction    start="has_language_privilege(" end=")" contains=ALL
syn region psqlFunction    start="has_schema_privilege(" end=")" contains=ALL
syn region psqlFunction    start="has_table_privilege(" end=")" contains=ALL
syn region psqlFunction    start="height(" end=")" contains=ALL
syn region psqlFunction    start="host(" end=")" contains=ALL
syn region psqlFunction    start="iclikejoinsel(" end=")" contains=ALL
syn region psqlFunction    start="iclikesel(" end=")" contains=ALL
syn region psqlFunction    start="icnlikejoinsel(" end=")" contains=ALL
syn region psqlFunction    start="icnlikesel(" end=")" contains=ALL
syn region psqlFunction    start="icregexeqjoinsel(" end=")" contains=ALL
syn region psqlFunction    start="icregexeqsel(" end=")" contains=ALL
syn region psqlFunction    start="icregexnejoinsel(" end=")" contains=ALL
syn region psqlFunction    start="icregexnesel(" end=")" contains=ALL
syn region psqlFunction    start="inet(" end=")" contains=ALL
syn region psqlFunction    start="initcap(" end=")" contains=ALL
syn region psqlFunction    start="int24div(" end=")" contains=ALL
syn region psqlFunction    start="int24eq(" end=")" contains=ALL
syn region psqlFunction    start="int24ge(" end=")" contains=ALL
syn region psqlFunction    start="int24gt(" end=")" contains=ALL
syn region psqlFunction    start="int24le(" end=")" contains=ALL
syn region psqlFunction    start="int24lt(" end=")" contains=ALL
syn region psqlFunction    start="int24mi(" end=")" contains=ALL
syn region psqlFunction    start="int24mod(" end=")" contains=ALL
syn region psqlFunction    start="int24mul(" end=")" contains=ALL
syn region psqlFunction    start="int24ne(" end=")" contains=ALL
syn region psqlFunction    start="int24pl(" end=")" contains=ALL
syn region psqlFunction    start="int28eq(" end=")" contains=ALL
syn region psqlFunction    start="int28ge(" end=")" contains=ALL
syn region psqlFunction    start="int28gt(" end=")" contains=ALL
syn region psqlFunction    start="int28le(" end=")" contains=ALL
syn region psqlFunction    start="int28lt(" end=")" contains=ALL
syn region psqlFunction    start="int28ne(" end=")" contains=ALL
syn region psqlFunction    start="int2abs(" end=")" contains=ALL
syn region psqlFunction    start="int2_accum(" end=")" contains=ALL
syn region psqlFunction    start="int2and(" end=")" contains=ALL
syn region psqlFunction    start="int2_avg_accum(" end=")" contains=ALL
syn region psqlFunction    start="int2div(" end=")" contains=ALL
syn region psqlFunction    start="int2(" end=")" contains=ALL
syn region psqlFunction    start="int2eq(" end=")" contains=ALL
syn region psqlFunction    start="int2fac(" end=")" contains=ALL
syn region psqlFunction    start="int2ge(" end=")" contains=ALL
syn region psqlFunction    start="int2gt(" end=")" contains=ALL
syn region psqlFunction    start="int2larger(" end=")" contains=ALL
syn region psqlFunction    start="int2le(" end=")" contains=ALL
syn region psqlFunction    start="int2lt(" end=")" contains=ALL
syn region psqlFunction    start="int2mi(" end=")" contains=ALL
syn region psqlFunction    start="int2mod(" end=")" contains=ALL
syn region psqlFunction    start="int2_mul_cash(" end=")" contains=ALL
syn region psqlFunction    start="int2mul(" end=")" contains=ALL
syn region psqlFunction    start="int2ne(" end=")" contains=ALL
syn region psqlFunction    start="int2not(" end=")" contains=ALL
syn region psqlFunction    start="int2or(" end=")" contains=ALL
syn region psqlFunction    start="int2pl(" end=")" contains=ALL
syn region psqlFunction    start="int2shl(" end=")" contains=ALL
syn region psqlFunction    start="int2shr(" end=")" contains=ALL
syn region psqlFunction    start="int2smaller(" end=")" contains=ALL
syn region psqlFunction    start="int2_sum(" end=")" contains=ALL
syn region psqlFunction    start="int2um(" end=")" contains=ALL
syn region psqlFunction    start="int2up(" end=")" contains=ALL
syn region psqlFunction    start="int2vectoreq(" end=")" contains=ALL
syn region psqlFunction    start="int2xor(" end=")" contains=ALL
syn region psqlFunction    start="int42div(" end=")" contains=ALL
syn region psqlFunction    start="int42eq(" end=")" contains=ALL
syn region psqlFunction    start="int42ge(" end=")" contains=ALL
syn region psqlFunction    start="int42gt(" end=")" contains=ALL
syn region psqlFunction    start="int42le(" end=")" contains=ALL
syn region psqlFunction    start="int42lt(" end=")" contains=ALL
syn region psqlFunction    start="int42mi(" end=")" contains=ALL
syn region psqlFunction    start="int42mod(" end=")" contains=ALL
syn region psqlFunction    start="int42mul(" end=")" contains=ALL
syn region psqlFunction    start="int42ne(" end=")" contains=ALL
syn region psqlFunction    start="int42pl(" end=")" contains=ALL
syn region psqlFunction    start="int48div(" end=")" contains=ALL
syn region psqlFunction    start="int48eq(" end=")" contains=ALL
syn region psqlFunction    start="int48ge(" end=")" contains=ALL
syn region psqlFunction    start="int48gt(" end=")" contains=ALL
syn region psqlFunction    start="int48le(" end=")" contains=ALL
syn region psqlFunction    start="int48lt(" end=")" contains=ALL
syn region psqlFunction    start="int48mi(" end=")" contains=ALL
syn region psqlFunction    start="int48mul(" end=")" contains=ALL
syn region psqlFunction    start="int48ne(" end=")" contains=ALL
syn region psqlFunction    start="int48pl(" end=")" contains=ALL
syn region psqlFunction    start="int4abs(" end=")" contains=ALL
syn region psqlFunction    start="int4_accum(" end=")" contains=ALL
syn region psqlFunction    start="int4and(" end=")" contains=ALL
syn region psqlFunction    start="int4_avg_accum(" end=")" contains=ALL
syn region psqlFunction    start="int4div(" end=")" contains=ALL
syn region psqlFunction    start="int4(" end=")" contains=ALL
syn region psqlFunction    start="int4eq(" end=")" contains=ALL
syn region psqlFunction    start="int4fac(" end=")" contains=ALL
syn region psqlFunction    start="int4ge(" end=")" contains=ALL
syn region psqlFunction    start="int4gt(" end=")" contains=ALL
syn region psqlFunction    start="int4inc(" end=")" contains=ALL
syn region psqlFunction    start="int4larger(" end=")" contains=ALL
syn region psqlFunction    start="int4le(" end=")" contains=ALL
syn region psqlFunction    start="int4lt(" end=")" contains=ALL
syn region psqlFunction    start="int4mi(" end=")" contains=ALL
syn region psqlFunction    start="int4mod(" end=")" contains=ALL
syn region psqlFunction    start="int4_mul_cash(" end=")" contains=ALL
syn region psqlFunction    start="int4mul(" end=")" contains=ALL
syn region psqlFunction    start="int4ne(" end=")" contains=ALL
syn region psqlFunction    start="int4not(" end=")" contains=ALL
syn region psqlFunction    start="int4notin(" end=")" contains=ALL
syn region psqlFunction    start="int4or(" end=")" contains=ALL
syn region psqlFunction    start="int4pl(" end=")" contains=ALL
syn region psqlFunction    start="int4shl(" end=")" contains=ALL
syn region psqlFunction    start="int4shr(" end=")" contains=ALL
syn region psqlFunction    start="int4smaller(" end=")" contains=ALL
syn region psqlFunction    start="int4_sum(" end=")" contains=ALL
syn region psqlFunction    start="int4um(" end=")" contains=ALL
syn region psqlFunction    start="int4up(" end=")" contains=ALL
syn region psqlFunction    start="int4xor(" end=")" contains=ALL
syn region psqlFunction    start="int82eq(" end=")" contains=ALL
syn region psqlFunction    start="int82ge(" end=")" contains=ALL
syn region psqlFunction    start="int82gt(" end=")" contains=ALL
syn region psqlFunction    start="int82le(" end=")" contains=ALL
syn region psqlFunction    start="int82lt(" end=")" contains=ALL
syn region psqlFunction    start="int82ne(" end=")" contains=ALL
syn region psqlFunction    start="int84div(" end=")" contains=ALL
syn region psqlFunction    start="int84eq(" end=")" contains=ALL
syn region psqlFunction    start="int84ge(" end=")" contains=ALL
syn region psqlFunction    start="int84gt(" end=")" contains=ALL
syn region psqlFunction    start="int84le(" end=")" contains=ALL
syn region psqlFunction    start="int84lt(" end=")" contains=ALL
syn region psqlFunction    start="int84mi(" end=")" contains=ALL
syn region psqlFunction    start="int84mul(" end=")" contains=ALL
syn region psqlFunction    start="int84ne(" end=")" contains=ALL
syn region psqlFunction    start="int84pl(" end=")" contains=ALL
syn region psqlFunction    start="int8abs(" end=")" contains=ALL
syn region psqlFunction    start="int8_accum(" end=")" contains=ALL
syn region psqlFunction    start="int8and(" end=")" contains=ALL
syn region psqlFunction    start="int8_avg(" end=")" contains=ALL
syn region psqlFunction    start="int8div(" end=")" contains=ALL
syn region psqlFunction    start="int8(" end=")" contains=ALL
syn region psqlFunction    start="int8eq(" end=")" contains=ALL
syn region psqlFunction    start="int8fac(" end=")" contains=ALL
syn region psqlFunction    start="int8ge(" end=")" contains=ALL
syn region psqlFunction    start="int8gt(" end=")" contains=ALL
syn region psqlFunction    start="int8inc(" end=")" contains=ALL
syn region psqlFunction    start="int8larger(" end=")" contains=ALL
syn region psqlFunction    start="int8le(" end=")" contains=ALL
syn region psqlFunction    start="int8lt(" end=")" contains=ALL
syn region psqlFunction    start="int8mi(" end=")" contains=ALL
syn region psqlFunction    start="int8mod(" end=")" contains=ALL
syn region psqlFunction    start="int8mul(" end=")" contains=ALL
syn region psqlFunction    start="int8ne(" end=")" contains=ALL
syn region psqlFunction    start="int8not(" end=")" contains=ALL
syn region psqlFunction    start="int8or(" end=")" contains=ALL
syn region psqlFunction    start="int8pl(" end=")" contains=ALL
syn region psqlFunction    start="int8shl(" end=")" contains=ALL
syn region psqlFunction    start="int8shr(" end=")" contains=ALL
syn region psqlFunction    start="int8smaller(" end=")" contains=ALL
syn region psqlFunction    start="int8_sum(" end=")" contains=ALL
syn region psqlFunction    start="int8um(" end=")" contains=ALL
syn region psqlFunction    start="int8up(" end=")" contains=ALL
syn region psqlFunction    start="int8xor(" end=")" contains=ALL
syn region psqlFunction    start="inter_lb(" end=")" contains=ALL
syn region psqlFunction    start="inter_sb(" end=")" contains=ALL
syn region psqlFunction    start="inter_sl(" end=")" contains=ALL
syn region psqlFunction    start="interval_accum(" end=")" contains=ALL
syn region psqlFunction    start="interval_avg(" end=")" contains=ALL
syn region psqlFunction    start="interval_cmp(" end=")" contains=ALL
syn region psqlFunction    start="interval_div(" end=")" contains=ALL
syn region psqlFunction    start="interval(" end=")" contains=ALL
syn region psqlFunction    start="interval_eq(" end=")" contains=ALL
syn region psqlFunction    start="interval_ge(" end=")" contains=ALL
syn region psqlFunction    start="interval_gt(" end=")" contains=ALL
syn region psqlFunction    start="interval_hash(" end=")" contains=ALL
syn region psqlFunction    start="interval_larger(" end=")" contains=ALL
syn region psqlFunction    start="interval_le(" end=")" contains=ALL
syn region psqlFunction    start="interval_lt(" end=")" contains=ALL
syn region psqlFunction    start="interval_mi(" end=")" contains=ALL
syn region psqlFunction    start="interval_mi_time(" end=")" contains=ALL
syn region psqlFunction    start="interval_mi_timetz(" end=")" contains=ALL
syn region psqlFunction    start="interval_mul(" end=")" contains=ALL
syn region psqlFunction    start="interval_ne(" end=")" contains=ALL
syn region psqlFunction    start="interval_pl(" end=")" contains=ALL
syn region psqlFunction    start="interval_pl_time(" end=")" contains=ALL
syn region psqlFunction    start="interval_smaller(" end=")" contains=ALL
syn region psqlFunction    start="interval_um(" end=")" contains=ALL
syn region psqlFunction    start="intinterval(" end=")" contains=ALL
syn region psqlFunction    start="isclosed(" end=")" contains=ALL
syn region psqlFunction    start="isfalse(" end=")" contains=ALL
syn region psqlFunction    start="isfinite(" end=")" contains=ALL
syn region psqlFunction    start="ishorizontal(" end=")" contains=ALL
syn region psqlFunction    start="isnotfalse(" end=")" contains=ALL
syn region psqlFunction    start="isnottrue(" end=")" contains=ALL
syn region psqlFunction    start="iso8859_1_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="iso8859_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="isopen(" end=")" contains=ALL
syn region psqlFunction    start="iso_to_alt(" end=")" contains=ALL
syn region psqlFunction    start="iso_to_koi8r(" end=")" contains=ALL
syn region psqlFunction    start="iso_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="iso_to_win1251(" end=")" contains=ALL
syn region psqlFunction    start="isparallel(" end=")" contains=ALL
syn region psqlFunction    start="isperp(" end=")" contains=ALL
syn region psqlFunction    start="istrue(" end=")" contains=ALL
syn region psqlFunction    start="isvertical(" end=")" contains=ALL
syn region psqlFunction    start="johab_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="koi8r_to_alt(" end=")" contains=ALL
syn region psqlFunction    start="koi8r_to_iso(" end=")" contains=ALL
syn region psqlFunction    start="koi8r_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="koi8r_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="koi8r_to_win1251(" end=")" contains=ALL
syn region psqlFunction    start="latin1_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="latin2_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="latin2_to_win1250(" end=")" contains=ALL
syn region psqlFunction    start="latin3_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="latin4_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="length(" end=")" contains=ALL
syn region psqlFunction    start="like(" end=")" contains=ALL
syn region psqlFunction    start="like_escape(" end=")" contains=ALL
syn region psqlFunction    start="likejoinsel(" end=")" contains=ALL
syn region psqlFunction    start="likesel(" end=")" contains=ALL
syn region psqlFunction    start="line_distance(" end=")" contains=ALL
syn region psqlFunction    start="line(" end=")" contains=ALL
syn region psqlFunction    start="line_eq(" end=")" contains=ALL
syn region psqlFunction    start="line_horizontal(" end=")" contains=ALL
syn region psqlFunction    start="line_interpt(" end=")" contains=ALL
syn region psqlFunction    start="line_intersect(" end=")" contains=ALL
syn region psqlFunction    start="line_parallel(" end=")" contains=ALL
syn region psqlFunction    start="line_perp(" end=")" contains=ALL
syn region psqlFunction    start="line_vertical(" end=")" contains=ALL
syn region psqlFunction    start="ln(" end=")" contains=ALL
syn region psqlFunction    start="lo_close(" end=")" contains=ALL
syn region psqlFunction    start="lo_creat(" end=")" contains=ALL
syn region psqlFunction    start="lo_export(" end=")" contains=ALL
syn region psqlFunction    start="log(" end=")" contains=ALL
syn region psqlFunction    start="lo_import(" end=")" contains=ALL
syn region psqlFunction    start="lo_lseek(" end=")" contains=ALL
syn region psqlFunction    start="lo_open(" end=")" contains=ALL
syn region psqlFunction    start="loread(" end=")" contains=ALL
syn region psqlFunction    start="lo_tell(" end=")" contains=ALL
syn region psqlFunction    start="lo_unlink(" end=")" contains=ALL
syn region psqlFunction    start="lower(" end=")" contains=ALL
syn region psqlFunction    start="lowrite(" end=")" contains=ALL
syn region psqlFunction    start="lpad(" end=")" contains=ALL
syn region psqlFunction    start="lseg_center(" end=")" contains=ALL
syn region psqlFunction    start="lseg_distance(" end=")" contains=ALL
syn region psqlFunction    start="lseg(" end=")" contains=ALL
syn region psqlFunction    start="lseg_eq(" end=")" contains=ALL
syn region psqlFunction    start="lseg_ge(" end=")" contains=ALL
syn region psqlFunction    start="lseg_gt(" end=")" contains=ALL
syn region psqlFunction    start="lseg_horizontal(" end=")" contains=ALL
syn region psqlFunction    start="lseg_interpt(" end=")" contains=ALL
syn region psqlFunction    start="lseg_intersect(" end=")" contains=ALL
syn region psqlFunction    start="lseg_le(" end=")" contains=ALL
syn region psqlFunction    start="lseg_length(" end=")" contains=ALL
syn region psqlFunction    start="lseg_lt(" end=")" contains=ALL
syn region psqlFunction    start="lseg_ne(" end=")" contains=ALL
syn region psqlFunction    start="lseg_parallel(" end=")" contains=ALL
syn region psqlFunction    start="lseg_perp(" end=")" contains=ALL
syn region psqlFunction    start="lseg_vertical(" end=")" contains=ALL
syn region psqlFunction    start="ltrim(" end=")" contains=ALL
syn region psqlFunction    start="macaddr_cmp(" end=")" contains=ALL
syn region psqlFunction    start="macaddr(" end=")" contains=ALL
syn region psqlFunction    start="macaddr_eq(" end=")" contains=ALL
syn region psqlFunction    start="macaddr_ge(" end=")" contains=ALL
syn region psqlFunction    start="macaddr_gt(" end=")" contains=ALL
syn region psqlFunction    start="macaddr_le(" end=")" contains=ALL
syn region psqlFunction    start="macaddr_lt(" end=")" contains=ALL
syn region psqlFunction    start="macaddr_ne(" end=")" contains=ALL
syn region psqlFunction    start="masklen(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_alt(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_ascii(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_big5(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_euc_cn(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_euc_jp(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_euc_kr(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_euc_tw(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_iso(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_koi8r(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_latin1(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_latin2(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_latin3(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_latin4(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_sjis(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_win1250(" end=")" contains=ALL
syn region psqlFunction    start="mic_to_win1251(" end=")" contains=ALL
syn region psqlFunction    start="mktinterval(" end=")" contains=ALL
syn region psqlFunction    start="mod(" end=")" contains=ALL
syn region psqlFunction    start="mul_d_interval(" end=")" contains=ALL
syn region psqlFunction    start="name(" end=")" contains=ALL
syn region psqlFunction    start="nameeq(" end=")" contains=ALL
syn region psqlFunction    start="namege(" end=")" contains=ALL
syn region psqlFunction    start="namegt(" end=")" contains=ALL
syn region psqlFunction    start="nameiclike(" end=")" contains=ALL
syn region psqlFunction    start="nameicnlike(" end=")" contains=ALL
syn region psqlFunction    start="nameicregexeq(" end=")" contains=ALL
syn region psqlFunction    start="nameicregexne(" end=")" contains=ALL
syn region psqlFunction    start="namele(" end=")" contains=ALL
syn region psqlFunction    start="namelike(" end=")" contains=ALL
syn region psqlFunction    start="namelt(" end=")" contains=ALL
syn region psqlFunction    start="namene(" end=")" contains=ALL
syn region psqlFunction    start="namenlike(" end=")" contains=ALL
syn region psqlFunction    start="nameregexeq(" end=")" contains=ALL
syn region psqlFunction    start="nameregexne(" end=")" contains=ALL
syn region psqlFunction    start="neqjoinsel(" end=")" contains=ALL
syn region psqlFunction    start="neqsel(" end=")" contains=ALL
syn region psqlFunction    start="netmask(" end=")" contains=ALL
syn region psqlFunction    start="network_cmp(" end=")" contains=ALL
syn region psqlFunction    start="network(" end=")" contains=ALL
syn region psqlFunction    start="network_eq(" end=")" contains=ALL
syn region psqlFunction    start="network_ge(" end=")" contains=ALL
syn region psqlFunction    start="network_gt(" end=")" contains=ALL
syn region psqlFunction    start="network_le(" end=")" contains=ALL
syn region psqlFunction    start="network_lt(" end=")" contains=ALL
syn region psqlFunction    start="network_ne(" end=")" contains=ALL
syn region psqlFunction    start="network_sub(" end=")" contains=ALL
syn region psqlFunction    start="network_subeq(" end=")" contains=ALL
syn region psqlFunction    start="network_sup(" end=")" contains=ALL
syn region psqlFunction    start="network_supeq(" end=")" contains=ALL
syn region psqlFunction    start="nextval(" end=")" contains=ALL
syn region psqlFunction    start="nlikejoinsel(" end=")" contains=ALL
syn region psqlFunction    start="nlikesel(" end=")" contains=ALL
syn region psqlFunction    start="nonnullvalue(" end=")" contains=ALL
syn region psqlFunction    start="notlike(" end=")" contains=ALL
syn region psqlFunction    start="now(" end=")" contains=ALL
syn region psqlFunction    start="npoints(" end=")" contains=ALL
syn region psqlFunction    start="nullvalue(" end=")" contains=ALL
syn region psqlFunction    start="numeric_abs(" end=")" contains=ALL
syn region psqlFunction    start="numeric_accum(" end=")" contains=ALL
syn region psqlFunction    start="numeric_add(" end=")" contains=ALL
syn region psqlFunction    start="numeric_avg(" end=")" contains=ALL
syn region psqlFunction    start="numeric_cmp(" end=")" contains=ALL
syn region psqlFunction    start="numeric_div(" end=")" contains=ALL
syn region psqlFunction    start="numeric(" end=")" contains=ALL
syn region psqlFunction    start="numeric_eq(" end=")" contains=ALL
syn region psqlFunction    start="numeric_exp(" end=")" contains=ALL
syn region psqlFunction    start="numeric_ge(" end=")" contains=ALL
syn region psqlFunction    start="numeric_gt(" end=")" contains=ALL
syn region psqlFunction    start="numeric_inc(" end=")" contains=ALL
syn region psqlFunction    start="numeric_larger(" end=")" contains=ALL
syn region psqlFunction    start="numeric_le(" end=")" contains=ALL
syn region psqlFunction    start="numeric_ln(" end=")" contains=ALL
syn region psqlFunction    start="numeric_log(" end=")" contains=ALL
syn region psqlFunction    start="numeric_lt(" end=")" contains=ALL
syn region psqlFunction    start="numeric_mod(" end=")" contains=ALL
syn region psqlFunction    start="numeric_mul(" end=")" contains=ALL
syn region psqlFunction    start="numeric_ne(" end=")" contains=ALL
syn region psqlFunction    start="numeric_power(" end=")" contains=ALL
syn region psqlFunction    start="numeric_smaller(" end=")" contains=ALL
syn region psqlFunction    start="numeric_sqrt(" end=")" contains=ALL
syn region psqlFunction    start="numeric_stddev(" end=")" contains=ALL
syn region psqlFunction    start="numeric_sub(" end=")" contains=ALL
syn region psqlFunction    start="numeric_uminus(" end=")" contains=ALL
syn region psqlFunction    start="numeric_uplus(" end=")" contains=ALL
syn region psqlFunction    start="numeric_variance(" end=")" contains=ALL
syn region psqlFunction    start="obj_description(" end=")" contains=ALL
syn region psqlFunction    start="octet_length(" end=")" contains=ALL
syn region psqlFunction    start="oid(" end=")" contains=ALL
syn region psqlFunction    start="oideq(" end=")" contains=ALL
syn region psqlFunction    start="oidge(" end=")" contains=ALL
syn region psqlFunction    start="oidgt(" end=")" contains=ALL
syn region psqlFunction    start="oidlarger(" end=")" contains=ALL
syn region psqlFunction    start="oidle(" end=")" contains=ALL
syn region psqlFunction    start="oidlt(" end=")" contains=ALL
syn region psqlFunction    start="oidne(" end=")" contains=ALL
syn region psqlFunction    start="oidnotin(" end=")" contains=ALL
syn region psqlFunction    start="oidrand(" end=")" contains=ALL
syn region psqlFunction    start="oidsmaller(" end=")" contains=ALL
syn region psqlFunction    start="oidsrand(" end=")" contains=ALL
syn region psqlFunction    start="oidvectoreq(" end=")" contains=ALL
syn region psqlFunction    start="oidvectorge(" end=")" contains=ALL
syn region psqlFunction    start="oidvectorgt(" end=")" contains=ALL
syn region psqlFunction    start="oidvectorle(" end=")" contains=ALL
syn region psqlFunction    start="oidvectorlt(" end=")" contains=ALL
syn region psqlFunction    start="oidvectorne(" end=")" contains=ALL
syn region psqlFunction    start="oidvectortypes(" end=")" contains=ALL
syn region psqlFunction    start="on_pb(" end=")" contains=ALL
syn region psqlFunction    start="on_pl(" end=")" contains=ALL
syn region psqlFunction    start="on_ppath(" end=")" contains=ALL
syn region psqlFunction    start="on_ps(" end=")" contains=ALL
syn region psqlFunction    start="on_sb(" end=")" contains=ALL
syn region psqlFunction    start="on_sl(" end=")" contains=ALL
syn region psqlFunction    start="overlaps(" end=")" contains=ALL
syn region psqlFunction    start="overlay(" end=")" contains=ALL
syn region psqlFunction    start="path_add(" end=")" contains=ALL
syn region psqlFunction    start="path_add_pt(" end=")" contains=ALL
syn region psqlFunction    start="path_center(" end=")" contains=ALL
syn region psqlFunction    start="path_contain_pt(" end=")" contains=ALL
syn region psqlFunction    start="path_distance(" end=")" contains=ALL
syn region psqlFunction    start="path_div_pt(" end=")" contains=ALL
syn region psqlFunction    start="path(" end=")" contains=ALL
syn region psqlFunction    start="path_inter(" end=")" contains=ALL
syn region psqlFunction    start="path_length(" end=")" contains=ALL
syn region psqlFunction    start="path_mul_pt(" end=")" contains=ALL
syn region psqlFunction    start="path_n_eq(" end=")" contains=ALL
syn region psqlFunction    start="path_n_ge(" end=")" contains=ALL
syn region psqlFunction    start="path_n_gt(" end=")" contains=ALL
syn region psqlFunction    start="path_n_le(" end=")" contains=ALL
syn region psqlFunction    start="path_n_lt(" end=")" contains=ALL
syn region psqlFunction    start="path_npoints(" end=")" contains=ALL
syn region psqlFunction    start="path_sub_pt(" end=")" contains=ALL
syn region psqlFunction    start="pclose(" end=")" contains=ALL
syn region psqlFunction    start="pg_backend_pid(" end=")" contains=ALL
syn region psqlFunction    start="pg_char_to_encoding(" end=")" contains=ALL
syn region psqlFunction    start="pg_client_encoding(" end=")" contains=ALL
syn region psqlFunction    start="pg_encoding_to_char(" end=")" contains=ALL
syn region psqlFunction    start="pg_function_is_visible(" end=")" contains=ALL
syn region psqlFunction    start="pg_get_constraintdef(" end=")" contains=ALL
syn region psqlFunction    start="pg_get_expr(" end=")" contains=ALL
syn region psqlFunction    start="pg_get_indexdef(" end=")" contains=ALL
syn region psqlFunction    start="pg_get_ruledef(" end=")" contains=ALL
syn region psqlFunction    start="pg_get_userbyid(" end=")" contains=ALL
syn region psqlFunction    start="pg_get_viewdef(" end=")" contains=ALL
syn region psqlFunction    start="pg_lock_status(" end=")" contains=ALL
syn region psqlFunction    start="pg_opclass_is_visible(" end=")" contains=ALL
syn region psqlFunction    start="pg_operator_is_visible(" end=")" contains=ALL
syn region psqlFunction    start="pg_show_all_settings(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_backend_activity(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_backend_dbid(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_backend_idset(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_backend_pid(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_backend_userid(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_blocks_fetched(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_blocks_hit(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_db_blocks_fetched(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_db_blocks_hit(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_db_numbackends(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_db_xact_commit(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_db_xact_rollback(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_numscans(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_tuples_deleted(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_tuples_fetched(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_tuples_inserted(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_tuples_returned(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_get_tuples_updated(" end=")" contains=ALL
syn region psqlFunction    start="pg_stat_reset(" end=")" contains=ALL
syn region psqlFunction    start="pg_table_is_visible(" end=")" contains=ALL
syn region psqlFunction    start="pg_type_is_visible(" end=")" contains=ALL
syn region psqlFunction    start="pi(" end=")" contains=ALL
syn region psqlFunction    start="plpgsql_call_handler(" end=")" contains=ALL
syn region psqlFunction    start="point_above(" end=")" contains=ALL
syn region psqlFunction    start="point_add(" end=")" contains=ALL
syn region psqlFunction    start="point_below(" end=")" contains=ALL
syn region psqlFunction    start="point_distance(" end=")" contains=ALL
syn region psqlFunction    start="point_div(" end=")" contains=ALL
syn region psqlFunction    start="point(" end=")" contains=ALL
syn region psqlFunction    start="point_eq(" end=")" contains=ALL
syn region psqlFunction    start="point_horiz(" end=")" contains=ALL
syn region psqlFunction    start="point_left(" end=")" contains=ALL
syn region psqlFunction    start="point_mul(" end=")" contains=ALL
syn region psqlFunction    start="point_ne(" end=")" contains=ALL
syn region psqlFunction    start="point_right(" end=")" contains=ALL
syn region psqlFunction    start="point_sub(" end=")" contains=ALL
syn region psqlFunction    start="point_vert(" end=")" contains=ALL
syn region psqlFunction    start="poly_center(" end=")" contains=ALL
syn region psqlFunction    start="poly_contained(" end=")" contains=ALL
syn region psqlFunction    start="poly_contain(" end=")" contains=ALL
syn region psqlFunction    start="poly_contain_pt(" end=")" contains=ALL
syn region psqlFunction    start="poly_distance(" end=")" contains=ALL
syn region psqlFunction    start="polygon(" end=")" contains=ALL
syn region psqlFunction    start="poly_left(" end=")" contains=ALL
syn region psqlFunction    start="poly_npoints(" end=")" contains=ALL
syn region psqlFunction    start="poly_overlap(" end=")" contains=ALL
syn region psqlFunction    start="poly_overleft(" end=")" contains=ALL
syn region psqlFunction    start="poly_overright(" end=")" contains=ALL
syn region psqlFunction    start="poly_right(" end=")" contains=ALL
syn region psqlFunction    start="poly_same(" end=")" contains=ALL
syn region psqlFunction    start="popen(" end=")" contains=ALL
syn region psqlFunction    start="position(" end=")" contains=ALL
syn region psqlFunction    start="positionjoinsel(" end=")" contains=ALL
syn region psqlFunction    start="positionsel(" end=")" contains=ALL
syn region psqlFunction    start="pow(" end=")" contains=ALL
syn region psqlFunction    start="pt_contained_circle(" end=")" contains=ALL
syn region psqlFunction    start="pt_contained_poly(" end=")" contains=ALL
syn region psqlFunction    start="quote_ident(" end=")" contains=ALL
syn region psqlFunction    start="quote_literal(" end=")" contains=ALL
syn region psqlFunction    start="radians(" end=")" contains=ALL
syn region psqlFunction    start="radius(" end=")" contains=ALL
syn region psqlFunction    start="random(" end=")" contains=ALL
syn region psqlFunction    start="regexeqjoinsel(" end=")" contains=ALL
syn region psqlFunction    start="regexeqsel(" end=")" contains=ALL
syn region psqlFunction    start="regexnejoinsel(" end=")" contains=ALL
syn region psqlFunction    start="regexnesel(" end=")" contains=ALL
syn region psqlFunction    start="reltime(" end=")" contains=ALL
syn region psqlFunction    start="reltimeeq(" end=")" contains=ALL
syn region psqlFunction    start="reltimege(" end=")" contains=ALL
syn region psqlFunction    start="reltimegt(" end=")" contains=ALL
syn region psqlFunction    start="reltimele(" end=")" contains=ALL
syn region psqlFunction    start="reltimelt(" end=")" contains=ALL
syn region psqlFunction    start="reltimene(" end=")" contains=ALL
syn region psqlFunction    start="repeat(" end=")" contains=ALL
syn region psqlFunction    start="replace(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_cascade_del(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_cascade_upd(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_check_ins(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_check_upd(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_noaction_del(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_noaction_upd(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_restrict_del(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_restrict_upd(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_setdefault_del(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_setdefault_upd(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_setnull_del(" end=")" contains=ALL
syn region psqlFunction    start="RI_FKey_setnull_upd(" end=")" contains=ALL
syn region psqlFunction    start="round(" end=")" contains=ALL
syn region psqlFunction    start="rpad(" end=")" contains=ALL
syn region psqlFunction    start="rtbeginscan(" end=")" contains=ALL
syn region psqlFunction    start="rt_bigbox_size(" end=")" contains=ALL
syn region psqlFunction    start="rt_box_inter(" end=")" contains=ALL
syn region psqlFunction    start="rt_box_size(" end=")" contains=ALL
syn region psqlFunction    start="rt_box_union(" end=")" contains=ALL
syn region psqlFunction    start="rtbuild(" end=")" contains=ALL
syn region psqlFunction    start="rtbulkdelete(" end=")" contains=ALL
syn region psqlFunction    start="rtcostestimate(" end=")" contains=ALL
syn region psqlFunction    start="rtendscan(" end=")" contains=ALL
syn region psqlFunction    start="rtgettuple(" end=")" contains=ALL
syn region psqlFunction    start="rtinsert(" end=")" contains=ALL
syn region psqlFunction    start="rtmarkpos(" end=")" contains=ALL
syn region psqlFunction    start="rt_poly_inter(" end=")" contains=ALL
syn region psqlFunction    start="rt_poly_size(" end=")" contains=ALL
syn region psqlFunction    start="rt_poly_union(" end=")" contains=ALL
syn region psqlFunction    start="rtrescan(" end=")" contains=ALL
syn region psqlFunction    start="rtrestrpos(" end=")" contains=ALL
syn region psqlFunction    start="rtrim(" end=")" contains=ALL
syn region psqlFunction    start="scalargtjoinsel(" end=")" contains=ALL
syn region psqlFunction    start="scalargtsel(" end=")" contains=ALL
syn region psqlFunction    start="scalarltjoinsel(" end=")" contains=ALL
syn region psqlFunction    start="scalarltsel(" end=")" contains=ALL
syn region psqlFunction    start="session_user(" end=")" contains=ALL
syn region psqlFunction    start="set_bit(" end=")" contains=ALL
syn region psqlFunction    start="set_byte(" end=")" contains=ALL
syn region psqlFunction    start="set_config(" end=")" contains=ALL
syn region psqlFunction    start="seteval(" end=")" contains=ALL
syn region psqlFunction    start="set_masklen(" end=")" contains=ALL
syn region psqlFunction    start="setseed(" end=")" contains=ALL
syn region psqlFunction    start="setval(" end=")" contains=ALL
syn region psqlFunction    start="sign(" end=")" contains=ALL
syn region psqlFunction    start="similar_escape(" end=")" contains=ALL
syn region psqlFunction    start="sin(" end=")" contains=ALL
syn region psqlFunction    start="sjis_to_euc_jp(" end=")" contains=ALL
syn region psqlFunction    start="sjis_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="sjis_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="slope(" end=")" contains=ALL
syn region psqlFunction    start="smgreq(" end=")" contains=ALL
syn region psqlFunction    start="smgrne(" end=")" contains=ALL
syn region psqlFunction    start="split_part(" end=")" contains=ALL
syn region psqlFunction    start="sqrt(" end=")" contains=ALL
syn region psqlFunction    start="strpos(" end=")" contains=ALL
syn region psqlFunction    start="substr(" end=")" contains=ALL
syn region psqlFunction    start="substring(" end=")" contains=ALL
syn region psqlFunction    start="tan(" end=")" contains=ALL
syn region psqlFunction    start="tcvn_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="textcat(" end=")" contains=ALL
syn region psqlFunction    start="text(" end=")" contains=ALL
syn region psqlFunction    start="texteq(" end=")" contains=ALL
syn region psqlFunction    start="text_ge(" end=")" contains=ALL
syn region psqlFunction    start="text_gt(" end=")" contains=ALL
syn region psqlFunction    start="texticlike(" end=")" contains=ALL
syn region psqlFunction    start="texticnlike(" end=")" contains=ALL
syn region psqlFunction    start="texticregexeq(" end=")" contains=ALL
syn region psqlFunction    start="texticregexne(" end=")" contains=ALL
syn region psqlFunction    start="text_larger(" end=")" contains=ALL
syn region psqlFunction    start="text_le(" end=")" contains=ALL
syn region psqlFunction    start="textlen(" end=")" contains=ALL
syn region psqlFunction    start="textlike(" end=")" contains=ALL
syn region psqlFunction    start="text_lt(" end=")" contains=ALL
syn region psqlFunction    start="textne(" end=")" contains=ALL
syn region psqlFunction    start="textnlike(" end=")" contains=ALL
syn region psqlFunction    start="textregexeq(" end=")" contains=ALL
syn region psqlFunction    start="textregexne(" end=")" contains=ALL
syn region psqlFunction    start="text_smaller(" end=")" contains=ALL
syn region psqlFunction    start="tideq(" end=")" contains=ALL
syn region psqlFunction    start="time_cmp(" end=")" contains=ALL
syn region psqlFunction    start="timedate_pl(" end=")" contains=ALL
syn region psqlFunction    start="time(" end=")" contains=ALL
syn region psqlFunction    start="time_eq(" end=")" contains=ALL
syn region psqlFunction    start="time_ge(" end=")" contains=ALL
syn region psqlFunction    start="time_gt(" end=")" contains=ALL
syn region psqlFunction    start="time_larger(" end=")" contains=ALL
syn region psqlFunction    start="time_le(" end=")" contains=ALL
syn region psqlFunction    start="time_lt(" end=")" contains=ALL
syn region psqlFunction    start="timemi(" end=")" contains=ALL
syn region psqlFunction    start="time_mi_interval(" end=")" contains=ALL
syn region psqlFunction    start="time_mi_time(" end=")" contains=ALL
syn region psqlFunction    start="time_ne(" end=")" contains=ALL
syn region psqlFunction    start="timenow(" end=")" contains=ALL
syn region psqlFunction    start="timeofday(" end=")" contains=ALL
syn region psqlFunction    start="timepl(" end=")" contains=ALL
syn region psqlFunction    start="time_pl_interval(" end=")" contains=ALL
syn region psqlFunction    start="time_smaller(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_cmp(" end=")" contains=ALL
syn region psqlFunction    start="timestamp(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_eq(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_ge(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_gt(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_larger(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_le(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_lt(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_mi(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_mi_span(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_ne(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_pl_span(" end=")" contains=ALL
syn region psqlFunction    start="timestamp_smaller(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_cmp(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_eq(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_ge(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_gt(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_larger(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_le(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_lt(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_mi(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_mi_span(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_ne(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_pl_span(" end=")" contains=ALL
syn region psqlFunction    start="timestamptz_smaller(" end=")" contains=ALL
syn region psqlFunction    start="timetz_cmp(" end=")" contains=ALL
syn region psqlFunction    start="timetzdate_pl(" end=")" contains=ALL
syn region psqlFunction    start="timetz(" end=")" contains=ALL
syn region psqlFunction    start="timetz_eq(" end=")" contains=ALL
syn region psqlFunction    start="timetz_ge(" end=")" contains=ALL
syn region psqlFunction    start="timetz_gt(" end=")" contains=ALL
syn region psqlFunction    start="timetz_hash(" end=")" contains=ALL
syn region psqlFunction    start="timetz_larger(" end=")" contains=ALL
syn region psqlFunction    start="timetz_le(" end=")" contains=ALL
syn region psqlFunction    start="timetz_lt(" end=")" contains=ALL
syn region psqlFunction    start="timetz_mi_interval(" end=")" contains=ALL
syn region psqlFunction    start="timetz_ne(" end=")" contains=ALL
syn region psqlFunction    start="timetz_pl_interval(" end=")" contains=ALL
syn region psqlFunction    start="timetz_smaller(" end=")" contains=ALL
syn region psqlFunction    start="timezone(" end=")" contains=ALL
syn region psqlFunction    start="tintervalct(" end=")" contains=ALL
syn region psqlFunction    start="tinterval(" end=")" contains=ALL
syn region psqlFunction    start="tintervalend(" end=")" contains=ALL
syn region psqlFunction    start="tintervaleq(" end=")" contains=ALL
syn region psqlFunction    start="tintervalge(" end=")" contains=ALL
syn region psqlFunction    start="tintervalgt(" end=")" contains=ALL
syn region psqlFunction    start="tintervalle(" end=")" contains=ALL
syn region psqlFunction    start="tintervalleneq(" end=")" contains=ALL
syn region psqlFunction    start="tintervallenge(" end=")" contains=ALL
syn region psqlFunction    start="tintervallengt(" end=")" contains=ALL
syn region psqlFunction    start="tintervallenle(" end=")" contains=ALL
syn region psqlFunction    start="tintervallenlt(" end=")" contains=ALL
syn region psqlFunction    start="tintervallenne(" end=")" contains=ALL
syn region psqlFunction    start="tintervallt(" end=")" contains=ALL
syn region psqlFunction    start="tintervalne(" end=")" contains=ALL
syn region psqlFunction    start="tintervalov(" end=")" contains=ALL
syn region psqlFunction    start="tintervalrel(" end=")" contains=ALL
syn region psqlFunction    start="tintervalsame(" end=")" contains=ALL
syn region psqlFunction    start="tintervalstart(" end=")" contains=ALL
syn region psqlFunction    start="to_ascii(" end=")" contains=ALL
syn region psqlFunction    start="to_char(" end=")" contains=ALL
syn region psqlFunction    start="to_date(" end=")" contains=ALL
syn region psqlFunction    start="to_hex(" end=")" contains=ALL
syn region psqlFunction    start="to_number(" end=")" contains=ALL
syn region psqlFunction    start="to_timestamp(" end=")" contains=ALL
syn region psqlFunction    start="translate(" end=")" contains=ALL
syn region psqlFunction    start="trunc(" end=")" contains=ALL
syn region psqlFunction    start="uhc_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="update_pg_pwd_and_pg_group(" end=")" contains=ALL
syn region psqlFunction    start="upper(" end=")" contains=ALL
syn region psqlFunction    start="userfntest(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_alt(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_ascii(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_big5(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_euc_cn(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_euc_jp(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_euc_kr(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_euc_tw(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_gb18030(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_gbk(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_iso8859_1(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_iso8859(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_johab(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_koi8r(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_sjis(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_tcvn(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_uhc(" end=")" contains=ALL
syn region psqlFunction    start="utf8_to_win1251(" end=")" contains=ALL
syn region psqlFunction    start="utf_to_win1250(" end=")" contains=ALL
syn region psqlFunction    start="utf_to_win1256(" end=")" contains=ALL
syn region psqlFunction    start="utf_to_win874(" end=")" contains=ALL
syn region psqlFunction    start="varbitcmp(" end=")" contains=ALL
syn region psqlFunction    start="varbit(" end=")" contains=ALL
syn region psqlFunction    start="varbiteq(" end=")" contains=ALL
syn region psqlFunction    start="varbitge(" end=")" contains=ALL
syn region psqlFunction    start="varbitgt(" end=")" contains=ALL
syn region psqlFunction    start="varbitle(" end=")" contains=ALL
syn region psqlFunction    start="varbitlt(" end=")" contains=ALL
syn region psqlFunction    start="varbitne(" end=")" contains=ALL
syn region psqlFunction    start="varcharcmp(" end=")" contains=ALL
syn region psqlFunction    start="varchar(" end=")" contains=ALL
syn region psqlFunction    start="varchareq(" end=")" contains=ALL
syn region psqlFunction    start="varcharge(" end=")" contains=ALL
syn region psqlFunction    start="varchargt(" end=")" contains=ALL
syn region psqlFunction    start="varcharle(" end=")" contains=ALL
syn region psqlFunction    start="varcharlt(" end=")" contains=ALL
syn region psqlFunction    start="varcharne(" end=")" contains=ALL
syn region psqlFunction    start="version(" end=")" contains=ALL
syn region psqlFunction    start="width(" end=")" contains=ALL
syn region psqlFunction    start="win1250_to_latin2(" end=")" contains=ALL
syn region psqlFunction    start="win1250_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="win1250_to_utf(" end=")" contains=ALL
syn region psqlFunction    start="win1251_to_alt(" end=")" contains=ALL
syn region psqlFunction    start="win1251_to_iso(" end=")" contains=ALL
syn region psqlFunction    start="win1251_to_koi8r(" end=")" contains=ALL
syn region psqlFunction    start="win1251_to_mic(" end=")" contains=ALL
syn region psqlFunction    start="win1251_to_utf8(" end=")" contains=ALL
syn region psqlFunction    start="win1256_to_utf(" end=")" contains=ALL
syn region psqlFunction    start="win874_to_utf(" end=")" contains=ALL
syn region psqlFunction    start="xideq(" end=")" contains=ALL

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_psql_syn_inits")
  if version < 508
    let did_psql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink psqlComment	Comment
  HiLink psqlKeyword	psqlSpecial
  HiLink psqlNumber	Number
  HiLink psqlOperator	psqlFunction
  HiLink psqlSpecial	Special
  HiLink psqlStatement	Statement
  HiLink psqlString	String
  HiLink psqlType	Type
  HiLink psqlFunction	Function
  HiLink psqlAggregate  Special

  delcommand HiLink
endif

let b:current_syntax = "psql"

" vim: ts=8
