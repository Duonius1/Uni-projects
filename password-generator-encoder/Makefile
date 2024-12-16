.PHONY: all clean rebuild run

all: main.exe

main.exe: main.cpp PasswordManager.o
	g++ -std=c++17 -o main.exe main.cpp PasswordManager.o

PasswordManager.o: PasswordManager.cpp PasswordManager.h
	g++ -std=c++17 -c  PasswordManager.cpp

clean:
	del main.exe PasswordManager.o

rebuild: clean all

run: main.exe
	.\main.exe