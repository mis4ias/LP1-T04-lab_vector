BINDIR = bin
SRCDIR = src
INCLUDEDIR = include
APPDIR = application
OBJDIR = build
TESTDIR = test

CC = g++

CFLAGS = -O3  -Wall -ansi -pedantic -std=c++11 -I $(INCLUDEDIR)

LDFLAGS =

BIN = ${BINDIR}/vect

APP = ${APPDIR}/main.cpp

SRC = $(wildcard $(SRCDIR)/*.cpp)
INC = $(wildcard $(INCLUDEDIR)/*.h)
OBJS = $(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.o,$(SRC))
APPOBJ = $(patsubst $(APPDIR)/%.cpp,$(OBJDIR)/%.o,$(APP))
INCOBJ = $(patsubst $(INCLUDEDIR)/%.h, $(OBJDIR)/%.o,$(INC))

_TESTS = $(wildcard $(TESTDIR)/*.cpp)
TESTS = $(patsubst %.cpp,%,$(_TESTS))

$(BIN): $(OBJS) $(APPOBJ) $(INCOBJ)
	$(CC) -o $(BIN) $(APPOBJ) $(OBJS) $(INCOBJ) $(CFLAGS) $(LDFLAGS)

$(APPOBJ): $(APP) 
	$(CC) -c -o $@ $< $(CFLAGS)

${OBJDIR}/%.o: $(SRCDIR)/%.cpp $(INCLUDEDIR)/%.h
	$(CC) -c -o $@ $< $(CFLAGS)

test: $(TESTS) $(INCOBJ) 
	$(info ************  Testes concluídos com sucesso! ************)

$(TESTDIR)/t_%: $(TESTDIR)/t_%.cpp $(OBJS) $(INCOBJ)
	$(CC) -o $@ $< $(OBJS) $(CFLAGS) $(LDFLAGS)
	$@

clean:
	rm -f $(BIN) $(OBJS) $(APPOBJ) $(INCOBJ)
	rm -f $(TESTS)
