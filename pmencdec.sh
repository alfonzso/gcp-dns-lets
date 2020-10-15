#!/bin/bash

my_array=( {a..z} {A..Z} {0..9} )
function atoi {
  printf ${1} | od -A n -t d1 | xargs
}

function get_index {
  value=${1}

  for i in "${!my_array[@]}"; do
    if [[ "${my_array[$i]}" = "${value}" ]]; then
        echo "${i}";
    fi
  done
}

function calc {
   awk "BEGIN { print $*}" | tr "." "," ;
}

function shift_calc  {
  # echo $( calc $( get_index ${1} ) / 2 )
  echo $(( $( get_index ${1} ) / 2 ))
}

to_encrypt="nononononononon"
pass="string"
encrypted=""

echo $to_encrypt
for (( x=0; x<${#to_encrypt}; x++ )); do
  for (( i=0; i<${#pass}; i++ )); do
    encrypted+="-$(echo $(( $( get_index "${to_encrypt:$x:1}" ) << $( shift_calc "${pass:$i:1}" ) )) )"
  done
done

echo $encrypted > pm.enc

idx=0
decrypted=""
for enc in $(echo $encrypted | tr "-" "\n")
do
  [[ $(( $idx % ${#pass} )) != "0" ]] && let idx++ && continue
  fa=$(( ${enc} >> $( shift_calc "${pass:0:1}" ) ))
  decrypted+=${my_array[$fa]}
  let idx++
done

echo $decrypted
