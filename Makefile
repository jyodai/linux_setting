all : help

help : 
	# make createExample  exampleファイルからファイルを生成する
	# make setup          各ツールをセットする
	# make symlin         ドットファイルのシンボリックリンクを作成
	# make unlink         ドットファイルのシンボリックリンクを解除

createExample : 
	sh ./tool/createExample.sh

setup :
	sh ./tool/symlink.sh
	sh ./tool/packageInstall.sh
	sh ./tool/vimInstall.sh

symlink :
	sh ./tool/symlink.sh

unlink :
	sh ./tool/symlink.sh u
