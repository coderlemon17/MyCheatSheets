#! /bin/bash

# flash the activate window real quick

transset -a -m 0 >/dev/null
sleep 0.08

transset -a -x 1 >/dev/null
sleep 0.08

transset -a -m 0 >/dev/null
sleep 0.08

transset -a --inc 1 >/dev/null


