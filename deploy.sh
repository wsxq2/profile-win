function cp_one_file(){
    local src dst
    src="$1"
    dst="$2"

    [[ ${dst:${#dst}-1} = / ]] && [[ ! -d "$dst" ]] && mkdir -p "$dst"
    cp -vfr "$src" "$dst"
}
cp_one_file $PWD/Microsoft.PowerShell_profile.ps1 $HOME/Documents/PowerShell/
cp_one_file $PWD/minttyrc $HOME/.minttyrc
