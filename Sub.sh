#! /usr/bin/env bash

# Converting SRT files encoding to UTF-8.
# Mahyar@Mahyar24.com, Thu 19 Aug 2021.


function convert() {

    file_type=$(file -b "${1}");
    sub_name="${1%%\.srt}";

    case "${file_type}" in
        "Non-ISO extended-ASCII text, with CRLF line terminators" | "Non-ISO extended-ASCII text, with CRLF, NEL line terminators")
            iconv -f WINDOWS-1256 -t UTF-8 "${1}" -o "${sub_name}_FIXED.srt";
            rm "${1}";;
        "Little-endian UTF-16 Unicode text, with CRLF, CR line terminators")
            iconv -f UTF-16 -t UTF-8 "${1}" -o "${sub_name}_FIXED.srt";
            rm "${1}";;
        "Big-endian UTF-16 Unicode text, with CRLF line terminators")
            iconv -f UTF-16BE -t UTF-8 "${1}" -o "${sub_name}_FIXED.srt";
            rm "${1}";;
        *)
            echo "${1}" "is correct already!";;
    esac

    }


if [[ "${1}" == "-r" ]]; then
  find . -type f -iname "*.srt" | while read -r sub; do convert "${sub}"; done;
else
  find . -maxdepth 1 -type f -iname "*.srt" | while read -r sub; do convert "${sub}"; done;
fi;
