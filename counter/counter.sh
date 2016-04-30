#!/bin/bash
# NAME: counter
# DESCRIPTION: Audibly counts up to a specified number.  Bishop and I created
# this during "take your son to work day".  He and I sat at the same desk and
# came up with this idea and coded it at work, at my desk, at Trustwave.
# AUTHOR: Dan Barrese & Bishop Barrese
# DATE: April 28, 2016

rate=200
skip=1
upper=
lower=0
quiet=false
while getopts "r:s:u:l:q" n; do
    case ${n} in
        r) # rate
            rate=${OPTARG}
            case ${rate} in
                "superfast")
                    rate=600
                    ;;
                "fast")
                    rate=300
                    ;;
                "slow")
                    rate=100
                    ;;
                *)
                    say "Invalid rate.  Goodbye."
                    exit 1
                    ;;
            esac
            ;;
        s) # skip
            skip=${OPTARG}
            ;;
        u) # upper
            upper=${OPTARG}
            ;;
        l) # lower
            lower=${OPTARG}
            ;;
        q) # quiet?
            quiet=true
            ;;
    esac
done

# printf '%s\n' "skip=${skip} rate=${rate} range=[${lower}, ${upper}]"

if [[ ${upper} == "" ]]; then
    say "I need an upper limit, please.  Goodbye"
fi

say_me=""
for (( i = $((${lower} + ${skip})); i <= ${upper}; i+=${skip} )); do
    say_me+="${i} "
done

if [[ ${quiet} == true ]]; then
    printf '%s\n' "${say_me}"
else
    say -r ${rate} "${say_me}"
fi

