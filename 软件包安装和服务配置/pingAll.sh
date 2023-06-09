#!/bin/bash
# 执行之后 就可以用arp来看IP了

IPBase="172.20.10."
IPBase2="16.16.20."
IPMAX=256

for (( IPNum = 0 ; ${IPNum} < ${IPMAX} ; IPNum = ${IPNum} + 1))
do
	# Mac os 
	# ping -c 2 ${IPBase}${IPNum} -t 1   2>/dev/null 1>/dev/null &
	# Linux
	ping -c 2 ${IPBase}${IPNum} -w 1   2>/dev/null 1>/dev/null &
	ping -c 2 ${IPBase2}${IPNum} -w 1  2>/dev/null 1>/dev/null &
done

