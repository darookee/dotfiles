#
# Authors:
#   Nils Uliczka <nils.uliczka@darookee.net>
#

# {{{ ark - Compress/decompress/list various archive types with a single command
ark() {
    case $1 in

        l)
            case $2 in
                *.tar.bz2)   tar tvjf $2      ;;
                *.tar.gz)    tar tvzf $2      ;;
                *.rar)       unrar l $2       ;;
                *.tar)       tar tvf $2       ;;
                *.tbz2)      tar tvjf $2      ;;
                *.tgz)       tar tvzf $2      ;;
                *.zip)       unzip -l $2      ;;
                *.7z)        7z l $2          ;;
                *)           echo "Cannot list contents of '$2' with >ark<" ;;
            esac ;;

        x)
            case $2 in
                *.tar.bz2)   tar xvjf $2      ;;
                *.tar.gz)    tar xvzf $2      ;;
                *.bz2)       bunzip2 $2       ;;
                *.rar)       unrar x $2       ;;
                *.gz)        gunzip $2        ;;
                *.tar)       tar xvf $2       ;;
                *.tbz2)      tar xvjf $2      ;;
                *.tgz)       tar xvzf $2      ;;
                *.zip)       unzip $2         ;;
                *.Z)         uncompress $2    ;;
                *.7z)        7z x $2          ;;
                *)           echo "Cannot unpack '$2' with >ark<" ;;
            esac ;;

        c)
            case $2 in
                *.tar.*)    arch=$2; shift 2;
                    tar cvf ${arch%.*} $@
                    case $arch in
                        *.gz)   gzip -9r ${arch%.*}   ;;
                        *.bz2)  bzip2 -9zv ${arch%.*} ;;
                    esac                              ;;
                *.rar)      shift; rar a -m5 -r $@; rar k $1    ;;
                *.zip)      shift; zip -9r $@                   ;;
                *.7z)       shift; 7z a -mx9 $@                 ;;
                *)          echo "Unsupported archive type"     ;;
            esac ;;

        *)
            echo "WATT?" ;;

    esac
}
# }}}
# tree {{{
if [ -z "\${which tree}" ]; then
  tree () {
      find $@ -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
  }
fi
# }}}
# archive - tar up directories and remove them {{{
archive() {
    if [ -d "${1}" ]; then
        archivedir=$(dirname "$1" )
        archivefile=${1#${archivedir}/}
        tar cvjf "${1}.tar.bz2" -C "${archivedir}" "${archivefile}" && 
        read -q "REMOVE?Remove '${1}' [y/N]? "
        [[ "${REMOVE}" == "y" ]] && rm -rf "${1}"
    else
        echo "Need an directory to archive."
    fi
}
# }}}

# vim:fdm=marker
