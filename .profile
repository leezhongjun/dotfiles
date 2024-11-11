mt () {
	cp ~/competitive-programming/template.cpp $1.cpp; vim $1.cpp
}

mtt () {
	cp ~/competitive-programming/template.cpp $1.cpp; vim $1.in; vim $1.ans; vim $1.cpp
}

cf () {
	g++ -include ../stdc++.h $1.cpp; timeout 5 ./a.out ; comm $1.ans $1.out
}

cfi () {
	g++ -include ../stdc++.h $1.cpp; timeout 5 cat $1.in | ./a.out > $1.out ; comm $1.ans $1.out
}

cd ~/competitive-programming/_USACO

export EDITOR=vim
export VISUAL=vim
alias v=vim
