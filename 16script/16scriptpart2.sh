#!/bin/bash

# {{{Colors
color00="$( xrdb -query | grep 'color0'     | cut -f2 | head -n 1 )"
color01="$( xrdb -query | grep 'color1'     | cut -f2 | head -n 1 )"
color02="$( xrdb -query | grep 'color2'     | cut -f2 | head -n 1 )"
color03="$( xrdb -query | grep 'color3'     | cut -f2 | head -n 1 )"
color04="$( xrdb -query | grep 'color4'     | cut -f2 | head -n 1 )"
color05="$( xrdb -query | grep 'color5'     | cut -f2 | head -n 1 )"
color06="$( xrdb -query | grep 'color6'     | cut -f2 | head -n 1 )"
color07="$( xrdb -query | grep 'color7'     | cut -f2 | head -n 1 )"
color08="$( xrdb -query | grep 'color8'     | cut -f2 | head -n 1 )"
color09="$( xrdb -query | grep 'color9'     | cut -f2 | head -n 1 )"
color10="$( xrdb -query | grep 'color10'    | cut -f2 | head -n 1 )"
color11="$( xrdb -query | grep 'color11'    | cut -f2 | head -n 1 )"
color12="$( xrdb -query | grep 'color12'    | cut -f2 | head -n 1 )"
color13="$( xrdb -query | grep 'color13'    | cut -f2 | head -n 1 )"
color14="$( xrdb -query | grep 'color14'    | cut -f2 | head -n 1 )"
color15="$( xrdb -query | grep 'color15'    | cut -f2 | head -n 1 )"
color16="$( xrdb -query | grep 'color16'    | cut -f2 | head -n 1 )"
color17="$( xrdb -query | grep 'color17'    | cut -f2 | head -n 1 )"
color18="$( xrdb -query | grep 'color18'    | cut -f2 | head -n 1 )"
color19="$( xrdb -query | grep 'color19'    | cut -f2 | head -n 1 )"
color20="$( xrdb -query | grep 'color20'    | cut -f2 | head -n 1 )"
color21="$( xrdb -query | grep 'color21'    | cut -f2 | head -n 1 )"
fg="$(      xrdb -query | grep 'foreground' | cut -f2 | head -n 1 )"
bg="$(      xrdb -query | grep 'background' | cut -f2 | head -n 1 )"
#}}}
cachedir="${HOME}/.cache/16script"
confdir="${HOME}/.config"
lastuse="$( < ${cachedir}/lastuse )"
dunstdir="${cachedir}/dunst"
rofidir="${cachedir}/rofi"

grad(){
	convert -size 1366x768 xc: -sparse-color  Barycentric \
	"0,%h ${color05}    90,90 ${color02}" \
	"${cachedir}/bg.png"
	feh --bg-fill "${cachedir}/bg.png"
}

dunsch(){
	if [[ ! -e "${dunstdir}" ]]; then
		mkdir "${dunstdir}"
	fi
	if [[ -e "${dunstdir}/${lastuse}.dunst" ]]; then
		cat "${dunstdir}/${lastuse}.dunst" > "${confdir}/dunst/dunstrc"
	else
		(
			sta="[urgency_low] [urgency_normal] [urgency_critical]"
			for c in ${sta}; do
				echo "${c}"
				printf "\tbackground = \"${bg}\"\n\tforeground = \"${fg}\"\n"
				if [[ ! "${c}" == "[urgency_critical]" ]]; then
					printf "\ttimeout = 4\n"
				else
					printf "\tframe_color=\"${color01}\"\n\ttimeout = 0\n"
				fi
			done
		) > "${dunstdir}/${lastuse}.dunst";
		(
			cat "${confdir}/dunst/origin.dunst";
			cat "${dunstdir}/${lastuse}.dunst"
		) > "${confdir}/dunst/dunstrc"
		cat "${confdir}/dunst/dunstrc" > "${dunstdir}/${lastuse}.dunst"
	fi
	sed -i "70i\	frame_color = \"${bg}\"" "${confdir}/dunst/dunstrc"

	killall dunst
	dunst &
	disown

	notify-send "16script" "You're now using ${lastuse}."
}

rasich(){
	if [[ ! -e "${rofidir}" ]]; then
		mkdir "${rofidir}"
	fi
	if [[ -e "${rofidir}/${lastuse}.rasi" ]]; then
		cat "${rofidir}/${lastuse}.rasi" > "${confdir}/rofi/16script.rasi"
	else
	(
#	{{{ 16script.rasi
		echo "* {";
		echo "    active-background: ${color19};";
		echo "    active-foreground: @foreground;";
		echo "    normal-background: @background;";
		echo "    normal-foreground: @foreground;";
		echo "    urgent-background: ${color01};";
		echo "    urgent-foreground: @foreground;";
		echo "";
		echo "    alternate-active-background: @background;";
		echo "    alternate-active-foreground: @foreground;";
		echo "    alternate-normal-background: @background;";
		echo "    alternate-normal-foreground: @foreground;";
		echo "    alternate-urgent-background: @background;";
		echo "    alternate-urgent-foreground: @foreground;";
		echo "";
		echo "    selected-active-background: ${color01};";
		echo "    selected-active-foreground: @foreground;";
		echo "    selected-normal-background: ${color19};";
		echo "    selected-normal-foreground: @foreground;";
		echo "    selected-urgent-background: ${color03};";
		echo "    selected-urgent-foreground: @foreground;";
		echo "";
		echo "    background-color: @background;";
		echo "    background: ${bg};";
		echo "    foreground: ${fg};";
		echo "    border-color: @background;";
		echo "    spacing: 0;";
		echo "}";
		echo "";
		echo "#window {";
		echo "    background-color: @background;";
		echo "    border: 0;";
		echo "    padding: 2.5ch;";
		echo "}";
		echo "";
		echo "#mainbox {";
		echo "    border: 0;";
		echo "    padding: 0;";
		echo "}";
		echo "";
		echo "#message {";
		echo "    border: 2px 0px 0px;";
		echo "    border-color: @border-color;";
		echo "    padding: 1px;";
		echo "}";
		echo "";
		echo "#textbox {";
		echo "    text-color: @foreground;";
		echo "}";
		echo "";
		echo "#listview {";
		echo "    fixed-height: 0;";
		echo "    border: 2px 0px 0px;";
		echo "    border-color: @border-color;";
		echo "    spacing: 2px;";
		echo "    scrollbar: true;";
		echo "    padding: 2px 0px 0px;";
		echo "}";
		echo "";
		echo "#element {";
		echo "    border: 0;";
		echo "    padding: 1px;";
		echo "}";
		echo "";
		echo "#element.normal.normal {";
		echo "    background-color: @normal-background;";
		echo "    text-color: @normal-foreground;";
		echo "}";
		echo "";
		echo "#element.normal.urgent {";
		echo "    background-color: @urgent-background;";
		echo "    text-color: @urgent-foreground;";
		echo "}";
		echo "";
		echo "#element.normal.active {";
		echo "    background-color: @active-background;";
		echo "    text-color: @active-foreground;";
		echo "}";
		echo "";
		echo "#element.selected.normal {";
		echo "    background-color: @selected-normal-background;";
		echo "    text-color: @selected-normal-foreground;";
		echo "}";
		echo "";
		echo "#element.selected.urgent {";
		echo "    background-color: @selected-urgent-background;";
		echo "    text-color: @selected-urgent-foreground;";
		echo "}";
		echo "";
		echo "#element.selected.active {";
		echo "    background-color: @selected-active-background;";
		echo "    text-color: @selected-active-foreground;";
		echo "}";
		echo "";
		echo "#element.alternate.normal {";
		echo "    background-color: @alternate-normal-background;";
		echo "    text-color: @alternate-normal-foreground;";
		echo "}";
		echo "";
		echo "#element.alternate.urgent {";
		echo "    background-color: @alternate-urgent-background;";
		echo "    text-color: @alternate-urgent-foreground;";
		echo "}";
		echo "";
		echo "#element.alternate.active {";
		echo "    background-color: @alternate-active-background;";
		echo "    text-color: @alternate-active-foreground;";
		echo "}";
		echo "";
		echo "#scrollbar {";
		echo "    width: 4px;";
		echo "    border: 0;";
		echo "    handle-width: 8px;";
		echo "    padding: 0;";
		echo "}";
		echo "";
		echo "#sidebar {";
		echo "    border: 2px 0px 0px;";
		echo "    border-color: @border-color;";
		echo "}";
		echo "";
		echo "#button.selected {";
		echo "    background-color: @selected-normal-background;";
		echo "    text-color: @selected-normal-foreground;";
		echo "}";
		echo "";
		echo "#inputbar {";
		echo "    spacing: 5;";
		echo "    text-color: @normal-foreground;";
		echo "    padding: 1px;";
		echo "}";
		echo "";
		echo "#case-indicator {";
		echo "    spacing: 0;";
		echo "    text-color: @normal-foreground;";
		echo "}";
		echo "";
		echo "#entry {";
		echo "    spacing: 1px;";
		echo "    text-color: @normal-foreground;";
		echo "}";
		echo "";
		echo "#prompt {";
		echo "    spacing: 0;";
		echo "    text-color: @normal-foreground;";
		echo "}"
#	}}}
	) > "${confdir}/rofi/16script.rasi"
	cat "${confdir}/rofi/16script.rasi" > "${rofidir}/${lastuse}.rasi"
	fi
}

main(){

#	grad
	rasich
	dunsch

}

main "${@}"
