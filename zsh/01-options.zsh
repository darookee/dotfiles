#
# Authors:
#   Nils Uliczka <nils.uliczka@darookee.net>
#

# Options {{{
#
setopt alwaystoend            # when completing from the middle of a word, move the cursor to the end of the word
setopt autocd                 # cd without cd
setopt autolist               # list choices on ambiguous completion
setopt automenu               # show menu on double-tab
setopt autoparamkeys          # remove space after completion, when closing brackt is inserted
setopt autoparamslash         # add slash after directory
setopt autopushd              # push to directory stack
setopt banghist               # treat ! special
setopt cdablevars             # cd ínto pathesfrom variables
setopt chaselinks             # resolve links when cding
setopt completeinword         # allow completion from within a word/phrase
setopt correct                # spelling correction for commands
setopt extendedglob           # use # ~ and ^ for globbing
setopt extendedhistory        # save start time and duration to history
setopt hashlistall            # hash everything before completion
setopt histexpiredupsfirst    # purge duplicates first when history needs trimming
setopt histfindnodups         # don't use duplicates as results for searching
setopt histignorealldups      # remove old duplicate command from history
setopt histignoredups         # don't save duplicate commands to history
setopt histignorespace        # don't save to history when command starts with space
setopt histsavenodups         # don't save duplicate entries
setopt histverify             # don't execute line with history expansion, just expand
setopt incappendhistory       # continious write history insted of waiting for shell exit
setopt listambiguous          # complete as much of a completion until it gets ambiguous.
setopt nocaseglob             # case insensitive glob
setopt noclobber              # dont overwrite existing files whn piping
setopt nocompletealiases      # don't complete alisases
setopt normstarsilent         # ask before rm *
setopt pathdirs               # perform path search for commands (X11/xinit -> /usr/local/bin/X11/xinit)
setopt promptsubst            # parameter expansion, command substitution and arithmetic expansion in prompt
setopt pushdignoredups        # Remove duplicate entries
setopt pushdminus             # This reverts the +/- operators.
setopt pushdsilent            # don't print stack after pushing
setopt pushdtohome            # `pushd` acts like `cd` -> `pushd $HOME`
setopt sharehistory           # share history between running sessions
# }}}
# Directories {{{
DIRSTACKSIZE=20
# }}}

# vim:fdm=marker ft=zsh
