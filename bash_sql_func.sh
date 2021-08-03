#!/bin/bash

#address & account
readonly DB_IP_ADDR="127.0.0.1"
readonly DB_ID="test"
readonly DB_PW="123qwe"

#DB_NAME
readonly DEC_DB_BITSTREAM="BITSTREAM"
readonly DEC_DB_MD5="MD5"

#TABLE_NAME of BITSTREAM & MD5
readonly TB_AVC_8B="AVC_8B"
readonly TB_AVC_10B="AVC_10B"
readonly TB_HEVC_8B="HEVC_8B"
readonly TB_HEVC_10B="HEVC_10B"
readonly TB_AVS2_8B="AVS2_8B"
readonly TB_AVS2_10B="AVS2_10B"
readonly TB_VP9_8B="VP9_8B"
readonly TB_VP9_10B="VP9_10B"
readonly TB_AV1_8B="AV1_8B"
readonly TB_AV1_10B="AV1_10B"


#echo "SHOW TABLES" | mysql -uqc_000 -p123qwe BITSTREAM

function sql_send_query
{
local db=$1
local query=$2

#echo "mysql -h$DB_IP_ADDR -u$DB_ID -p$DB_PW $db -e$query"

mysql -h"$DB_IP_ADDR" -u"$DB_ID" -p"$DB_PW" $db -e"$query"
}

function sql_show_tables
{
    local db=$1

    ret=$(sql_send_query $db "SHOW TABLES")
    for tb_name in $ret;
    do
        echo $tb_name
    done
}

function sql_get_tb_data_num
{
    local db=$1
    local tb=$2

    local tb_data_num=0
    ret=$(sql_send_query $db "select count(*) from ${tb}")

    for num in $ret;
    do
        tb_data_num=$num
        #echo $tb_data_num
    done

    echo $tb_data_num
}

function sql_get_row_by_num
{
    local db=$1
    local tb=$2
    local row=$3

    ret=$(sql_send_query $db "select * from $tb order by name ASC limit $row,1")

    echo "$ret"
}

function sql_search_row_by_condition
{
    local db=$1
    local tb=$2
    local col=$3
    local condition=$4

    ret=$(sql_send_query $db "select * from $tb where ${col}='${condition}'")

    echo "$ret"
}

function sql_search_col_data_by_condition
{
    local db=$1
    local tb=$2
    local col_searched=$3
    local col_found=$4
    local condition=$5

    ret=$(sql_send_query $db "select ${col_found} from $tb where ${col_searched}='${condition}'")

    echo "$ret"
}

function sql_search_row_by_like
{
    local db=$1
    local tb=$2
    local col=$3
    local condition=$4

    ret=$(sql_send_query $db "select * from $tb where ${col} like '%${condition}%'")
    
    echo "$ret"
}

function sql_get_stream_full_path_by_row
{
    local db=$1
    local tb=$2
    local row=$3
    local idx=0
    local name=""
    local path=""

    ret=$(sql_get_row_by_num $db $tb $row)

    idx=0
    for val in $ret;
    do
        if (( $idx == 2 ));  then
            name="$val"
        elif (( $idx == 3 )); then
            path="$val"
        fi
        idx=$(($idx+1))
    done

    path=${path}/${name}
    echo "$path"
}

function sql_get_stream_full_path_by_name
{
    echo "TODO"
}

function sql_get_8b_md5_full_path_by_name
{
    local db=$1
    local tb=$2
    local condition=$3
    local idx=0
    local md5_path=""
    local md5_name=""

    ret=$(sql_search_row_by_condition  $db $tb "name" $condition)

    idx=0
    for val in $ret;
    do
        if (( $idx == 4 ));  then
            md5_path="$val"
        elif (( $idx == 5 )); then
            md5_name="$val"
        fi
        idx=$(($idx+1))
    done
    md5_path=${md5_path}/${md5_name}
    echo "$md5_path"
}















