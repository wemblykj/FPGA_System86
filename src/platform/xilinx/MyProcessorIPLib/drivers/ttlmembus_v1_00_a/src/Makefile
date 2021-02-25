COMPILER=
ARCHIVER=
CP=cp
COMPILER_FLAGS=
EXTRA_COMPILER_FLAGS=
LIB=libxil.a

RELEASEDIR=../../../lib
INCLUDEDIR=../../../include
INCLUDES=-I./. -I${INCLUDEDIR}

INCLUDEFILES=xttlmembus_l.h xttlmembus.h

LIBSOURCES=*.c
OUTS = *.o 


libs:
	echo "Compiling ttlmembus"
	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) $(INCLUDES) $(LIBSOURCES)
	$(ARCHIVER) -r ${RELEASEDIR}/${LIB} $(OUTS)
	make clean

include: 
	 ${CP} ${INCLUDEFILES} ${INCLUDEDIR} 

clean:
	rm -rf ${OUTS}
