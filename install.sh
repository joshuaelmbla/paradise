# !/bin/sh

cr="\033[1;31m"
cg="\033[1;32m"
cb="\033[1;34m"

help(){
  printf "${cg}Usage: ./install.sh ${cb}[l|h] [a|h]${cg}
    ${cb}l:${cg} light theme
    ${cb}d:${cg} dark theme
    ${cb}a:${cg} allow all
    ${cb}h:${cg} help\n"
  exit
}

while true; do
  case $1 in
    -l*|--l*|l*) theme="light";;
    -d*|--d*|d*) theme="dark";;
    -a*|--a*|a*) allow="yes";;
    -h*|--h*|h*) help;;
    *) break;;
  esac
  shift
done

for a in $(ls $theme --hide powershell); do
  printf "${cb}"
  [ "$allow" = "yes" ] || read -p "Install Paradise for $a? [Yes|No]: " allow
  case $allow in
    Y*|y*) cp -r $theme/$a $HOME/.config/.
      case $a in
        alacritty) printf "import:\n  - ~/.config/alacritty/paradise.yml\n" >> $HOME/.config/alacritty/alacritty.yml;;
        kitty) printf "include ~/.config/kitty/paradise.conf\n" >> $HOME/.config/kitty/kitty.conf;;
      esac
      ;;
    *) printf "${cr}[-] Skipped\n";;
  esac
done
printf "${cg}[*] $theme Theme Installed.\n"
