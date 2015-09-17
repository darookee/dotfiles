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
    case $1 in
        ls)
            if [ -d "${archivedir}" ]; then
                if [ -f "${archivedir}/${2}" ]; then
                    tar tvjf "${archivedir}/${2}"
                else
                    ls -lh "${archivedir}"|sed -n '1!p'|awk '{ print $9 " " $5 }'
                fi
            fi
            ;;
        rm)
            archivetorm="${archivedir}/${2}"
            read -q "REMOVE?Remove '${2}' from archive [y/N]? "
            [[ "${REMOVE}" == "y" ]] && rm -f "${archivetorm}"
            echo "\n"
            ;;
        restore)
            archivetorestore="${archivedir}/${2}"
            restorepath=$(sed 's/-/\//g' <<< $2)
            restorepath=$(dirname "${restorepath%.tar.bz2}")
            if [ ! -d "${restorepath}" ]; then
                mkdir -p "${restorepath}"
            fi
            echo "Restoring into '${restorepath}'"
            tar xjf "${archivetorestore}" -C "${restorepath}"
            read -q "REMOVE?Remove '${2}' from archive [y/N]? "
            [[ "${REMOVE}" == "y" ]] && rm -f "${archivetorestore}"
            echo "\n"
            ;;
        add)
            if [ -d "${2}" ]; then
                archivebasedir=$(dirname "$2")
                if [ ! -d "${archivedir}" ]; then
                    archivedir="$archivebasedir"
                fi
                archivefile="${2#${archivebasedir}/}"
                archive="${archivedir}/$(sed 's/\//-/g' <<< $2).tar.bz2"
                echo "Archiving '${archivefile}'"
                tar cjf "${archive}" -C "${archivebasedir}" "${archivefile}" && 
                read -q "REMOVE?Remove '${2}' [y/N]? "
                [[ "${REMOVE}" == "y" ]] && rm -rf "${2}"
                echo "\n"
            else
                echo "Need an directory to archive."
            fi
            ;;
        stats)
            if [[ "" == "${2}" ]]; then
                size=$(du -sh "${archivedir}"|awk '{print $1}')
                files=$(ls -1 "${archivedir}"|wc -l)
                echo "Containing $fg[yellow]${files}$fg[white] archives with total size of $fg[red]${size}$fg[white]"
            else
                if [ -f "${archivedir}/${2}" ]; then
                    rawinfo=$(stat "${archivedir}/${2}")
                    created=$(echo $rawinfo|grep "Change"|awk -F\: '{ print $2 }')
                    size=$(du -h "${archivedir}/${2}"|awk '{print $1}')
                    echo "Size: ${size}"
                    echo "Created: ${created}"
                else
                    echo "No archive by that name"
                fi
            fi
            ;;
        *)
            echo "Unknown option."
            echo "add - add directory to archive"
            echo "ls - list archives or contents"
            echo "restore - restore files from archive"
            echo "rm - remove from archive"
            echo "stats - show stats about archives"
            ;;
    esac
}
# }}}

# vim:fdm=marker
