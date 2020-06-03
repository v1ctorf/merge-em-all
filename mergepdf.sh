#!/bin/sh
clear;
printf " _______  _______  _______  _______  _______  _  _______  _______    _______  _        _        _\n";
printf "(       )(  ____ \(  ____ )(  ____ \(  ____ \( )(  ____ \(       )  (  ___  )( \      ( \      ( )\n";
printf "| () () || (    \/| (    )|| (    \/| (    \/|/ | (    \/| () () |  | (   ) || (      | (      | |\n";
printf "| || || || (__    | (____)|| |      | (__       | (__    | || || |  | (___) || |      | |      | |\n";
printf "| |(_)| ||  __)   |     __)| | ____ |  __)      |  __)   | |(_)| |  |  ___  || |      | |      | |\n";
printf "| |   | || (      | (\ (   | | \_  )| (         | (      | |   | |  | (   ) || |      | |      (_)\n";
printf "| )   ( || (____/\| ) \ \__| (___) || (____/\   | (____/\| )   ( |  | )   ( || (____/\| (____/\ _ \n";
printf "|/     \|(_______/|/   \__/(_______)(_______/   (_______/|/     \|  |/     \|(_______/(_______/(_)\n\n\n";
printf "removing all temporary pdf files...\n";
rm temp*
printf "\nhow many ordered files do u want to merge?\n"
read END
A=1;
B=2;
for i in $(seq 1 $END);
do
    temp=$(printf "temp%d.pdf" $B);
    oldtemp=$(printf "temp%d.pdf" $A);
    filea=$(printf "../%03d.pdf" $A);
    fileb=$(printf "../%03d.pdf" $B);

    if [ -f "$oldtemp" ]; then
        filea="$oldtemp";
    fi

    if [ ! -f "$fileb" ]; then
        B=$((B+1));
        continue;
    fi

    now=$(date +"%T")
    printf "\n$now - step ${i}/${END}: pdfunite ${filea} + ${fileb} => ${temp}\n";
    pdfunite "${filea}" "${fileb}" "${temp}";

    if [ -f "$oldtemp" ]; then
        rm "$oldtemp";
    fi

    ls -d -la t* -lh | awk '{print $9, $5}'

    A=$B;
    B=$((B+1));
done
printf "\n\n$now - End of execution. Resulting file: ";
ls -d -la t* -lh | awk '{print $9, $5}'
printf "\n";