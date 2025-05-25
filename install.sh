#/bin/bash

R_CONFIG_DIR=home/.config
L_CONFIG_DIR=$HOME/.config

printf "Would you like to copy the directories (y (copy)/N (symlink))? "
read -r should_copy

if [[ $should_copy =~ ^[Yy]$ ]]; then
    should_copy=true
else
    should_copy=false
fi



for f in $R_CONFIG_DIR/*; do
    L_DIR=$L_CONFIG_DIR/$(basename $f)

    if [[ -d $L_DIR ]]; then
        printf "%s already exists, should it be replaced (y/N)? " $L_DIR
        read -r should_delete

        if [[ $should_delete =~ ^[Yy]$ ]]; then
            echo Replacing $(basename $f)
            echo "+ rm -rf $L_DIR"
            rm -rf $L_DIR
        fi

        [[ ! $should_delete ]] && continue
    fi 

    R_DIR=$PWD/"$R_CONFIG_DIR"/$(basename $f)

    if $should_copy; then
        echo "+ cp -r $R_DIR $(dirname $L_DIR)"
        cp -r $R_DIR $(dirname $L_DIR)
    else
        echo "+ ln -sf $R_DIR $(dirname $L_DIR)"
        ln -sf $R_DIR $(dirname $L_DIR)
    fi
done

Z=("home/.zshrc")

for f in "${Z[@]}"; do
    L_DIR=$HOME/$(basename $f)

    if [[ -f $L_DIR ]]; then
        printf "%s already exists, should it be replaced (y/N)? " $L_DIR
        read -r should_delete

        if [[ $should_delete =~ ^[Yy]$ ]]; then
            echo Replacing $(basename $f)
            echo "+ rm -rf $L_DIR"
            rm -rf $L_DIR
        fi

        [[ ! $should_delete ]] && continue
    fi 

    R_DIR=$PWD/$f

    if $should_copy; then
        echo "+ cp -r $R_DIR $L_DIR"
        cp -r $R_DIR $L_DIR
    else
        echo "+ ln -sf $R_DIR $L_DIR"
        ln -sf $R_DIR $L_DIR
    fi
done

echo "DONE - Goodbye"
