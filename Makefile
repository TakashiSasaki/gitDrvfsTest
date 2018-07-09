.PHONY: prepare git1 git2 git3 git4 repo default repoSub

default:
	@echo Hello

prepare:
	sudo apt-get install -y libssh-dev libssl-dev autoconf \
		gettext libcurl4-openssl-dev libexpat1-dev libjconv-dev
	-/usr/bin/git submodule add -f --depth=1 https://github.com/git/git.git
	-/usr/bin/git submodule add -f --depth=1 ./git git1
	-/usr/bin/git submodule add -f --depth=1 ./git git2
	-usr/bin/git submodule add -f --depth=1 ./git git3
	-/usr/bin/git submodule add -f --depth=1 ./git git4

clean:
	make -C git clean
	cd git; git clean -dxf
	make -C git1 clean
	cd git1; git clean -dxf
	make -C git2 clean
	cd git2; git clean -dxf
	make -C git3 clean
	cd git3; git clean -dxf
	make -C git4 clean
	cd git4; git clean -dxf

gitAll: git1 git2 git3 git4

git1:
	cd git1 ;\
	make clean ;\
	make configure ;\
	./configure --without-tcltk --prefix=/tmp/git1
	make -C $@
	make -C $@ install

git2:
	cd git2; \
	make clean; \
	make configure NO_MMAP=1;\
	./configure --without-tcltk --prefix=/tmp/git2; 
	make -C $@ NO_MMAP=1
	make -C $@ NO_MMAP=1 install

git3:
	cd git3; \
	make clean; \
	make configure;\
	./configure --without-tcltk --prefix=/tmp/git3 NO_MMAP=1; 

git4:
	cd git4; \
	make clean; \
	make configure NO_MMAP=1;\
	./configure --without-tcltk --prefix=/tmp/git4 NO_MMAP=1; 


repoSub:
ifndef TARGET
	@echo TARGET is not defined.
	@exit 99
endif
ifndef GITBIN
	@echo GITN is not defined.
	@exit 99
endif
	@sudo rm -rf $(TARGET)/repo
	@mkdir $(TARGET)/repo
	-cd $(TARGET)/repo; $(SUDO) $(GITBIN) init
	@echo -e 

repo:
	make repoSub TARGET=$(HOME) GITBIN=git SUDO=
	make repoSub TARGET=$(HOME) GITBIN=/tmp/git1/bin/git SUDO=
	make repoSub TARGET=$(HOME) GITBIN=/tmp/git2/bin/git SUDO=
	make repoSub TARGET=/mnt/c/tmp GITBIN=git SUDO=
	make repoSub TARGET=/mnt/c/tmp GITBIN=/tmp/git1/bin/git SUDO=
	make repoSub TARGET=/mnt/c/tmp GITBIN=/tmp/git2/bin/git SUDO=
	make repoSub TARGET=/mnt/c/tmp GITBIN=git SUDO=sudo
	make repoSub TARGET=/mnt/c/tmp GITBIN=/tmp/git1/bin/git SUDO=sudo
	make repoSub TARGET=/mnt/c/tmp GITBIN=/tmp/git2/bin/git SUDO=sudo
