PREFIX?=	/usr/local
BINDIR?=	${PREFIX}/bin
MANDIR?=	${PREFIX}/share/man/man1

PROG=		zz80asm

SRCS=		zz80asm.c num.c out.c pfun.c rfun.c tab.c

CFLAGS+=	-g
CFLAGS+=	-Wall -Wextra -std=c99 -Wcast-qual -Wformat=2
CFLAGS+=	-Wmissing-declarations -Wundef
CFLAGS+=	-Wpointer-arith -Wuninitialized -Wmissing-prototypes
CFLAGS+=	-Wsign-compare -Wshadow -Wdeclaration-after-statement
CFLAGS+=	-Wfloat-equal -Wcast-align -Wstrict-aliasing=2

CFLAGS+=	-Wno-char-subscripts -Wno-implicit-function-declaration

all: ${PROG} readme

${PROG}: ${SRCS}
	${CC} ${CFLAGS} ${SRCS} -o $@

clean:
	rm -f ${PROG} core *.o

install: ${PROG}
	@mkdir -p ${BINDIR}
	@mkdir -p ${MANDIR}
	install ${PROG} ${BINDIR}
	install ${PROG}.1 ${MANDIR}

uninstall:
	rm ${BINDIR}/${PROG}
	rm ${MANDIR}/${PROG}.1

readme: ${PROG}.1
	mandoc ${.CURDIR}/${PROG}.1 | col -bx > ${.CURDIR}/README

.PHONY: all clean install uninstall readme
