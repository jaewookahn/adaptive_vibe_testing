#!/bin/sh

./lda est 5 $2 settings.txt data/gt_$1.txt random model-$2-$1
./lda inf inf-settings.txt model-$2-$1/final data/notes_$1.txt inf/inf-$2-$1
#./topics.py model-$1/final.beta vibe/$1_voc.dat 5
