/*
 *
 * Boolean Logic Game
 *
 * Jeff Tranter <tranter@pobox.com>
 *
 * TO DO:
 * Parse data file and read into data structure.
 * Beep on bad input.
 */

// Includes

#ifdef __CC65__
#include <apple2enh.h>
#include <conio.h>
#include <peekpoke.h>
#endif
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Constants

#define MAX_ENTRIES 16
#define MAX_GAMES 10
#define MAX_INPUTS 4
#define MAX_OUTPUTS 1
#ifdef __CC65__
#define TUTORIAL "tutorial"
#define OVERVIEW "overview"
#define LEVELS "levels"
#else
#define TUTORIAL "tutorial.txt"
#define OVERVIEW "overview.txt"
#define LEVELS "levels.csv"
#endif

// Data types

typedef struct game_t {
    char name[40];
    char expression[40];
    int level;
    int numInputs;
    int numOutputs;
    int numEntries;
    char imageFile[20];
    int input[MAX_ENTRIES][MAX_INPUTS];
    int output[MAX_ENTRIES][MAX_INPUTS];
} game_t;

// Global variables

int difficultyLevel = 1;
game_t games[MAX_GAMES];
int numGames = 0;

// Functions

// Clear the screen.
void clearScreen()
{
#ifdef __CC65__
    clrscr();
#endif
}

// Make an error beep.
void beep()
{
    putchar('\a');
}

// Prompt user to press a key to continue.
void pressKeyToContinue()
{
    printf("<Press any key to continue> ");
#ifdef __CC65__
    cgetc();
#else
    getchar();
#endif
    printf("\n");
}

// Read game data file into data structure.
void readDataFile(const char *filename)
{
    FILE *fp;
    char buffer[80];
    char *p;
    int i, e, in, out;

    printf("Reading data file...");

#ifdef __CC65__
    _filetype = PRODOS_T_TXT;
#endif

    fp = fopen(filename, "r");

    if (fp == NULL) {
        perror(filename);
        exit(EXIT_FAILURE);
        return;
    }

    while (!feof(fp)) {
        fgets(buffer, sizeof(buffer)-1, fp);

        assert(i < MAX_GAMES);
        p = strtok(buffer, ",");
        strcpy(games[i].name, p);
        p = strtok(NULL, ",");
        strcpy(games[i].expression, p);
        p = strtok(NULL, ",");
        games[i].level = atol(p);
        p = strtok(NULL, ",");
        games[i].numInputs = atol(p);
        assert(games[i].numInputs <= MAX_INPUTS);
        p = strtok(NULL, ",");
        games[i].numOutputs = atol(p);
        assert(games[i].numOutputs <= MAX_OUTPUTS);
        p = strtok(NULL, ",");
        games[i].numEntries = atol(p);
        assert(games[i].numEntries <= MAX_ENTRIES);
        p = strtok(NULL, ",\n");
        strcpy(games[i].imageFile, p);

        for (e = 0; e < games[i].numEntries; e++) {
            fgets(buffer, sizeof(buffer)-1, fp);
            p = strtok(buffer, ",");
            for (in = 0; in < games[i].numInputs; in++) {
                games[i].input[e][in] = atol(p);
                p = strtok(NULL, ",\n");
            }
            for (out = 0; out < games[i].numOutputs; out++) {
                games[i].output[e][out] = atol(p);
                p = strtok(NULL, ",\n");
            }
        }
        i++;
    }
    numGames = i;
    fclose(fp);
    printf("done.\n");
}

// Print file on screen with paging every 24 lines.
void showFile(const char *filename) {
    FILE *fp;
    char buffer[80];
    int lines = 0;

#ifdef __CC65__
    _filetype = PRODOS_T_TXT;
#endif

    fp = fopen(filename, "r");

    if (fp == NULL) {
        perror(filename);
        exit(EXIT_FAILURE);
        return;
    }

    clearScreen();

    while (!feof(fp)) {
        fgets(buffer, sizeof(buffer)-1, fp);
        printf("%s", buffer);

        lines++;
        if (lines >= 23) {
            pressKeyToContinue();
            lines = 0;
        }
    }

    pressKeyToContinue();
    fclose(fp);
}

int selectDifficulty()
{
    char c;

    printf("Select Difficulty Level:\n");
    printf("1. Basic Gates.\n");
    printf("2. Simple Circuits.\n");
    printf("3. Intermediate Circuits.\n");
    printf("4. Complex circuit.\n");
    printf("5. Return to main menu.\n");
    printf("Selection? ");

    while (1) {
#ifdef __CC65__
        c = cgetc();
#else
        c = getchar();
#endif
        if (c >= '1' && c <= '5') {
            break;
        } else {
            beep();
        }
    }

    return c - '0';
}

void fillInTruthTable()
{
    int g, i, e, o;

    //difficultyLevel = selectDifficulty();

    for (g = 0; g < numGames; g++) {
        printf("Name: %s\n", games[g].name);
        printf("Expression: %s\n", games[g].expression);
        printf("Level: %d\n", games[g].level);
        printf("File: %s\n", games[g].imageFile);

        for (i = 0; i < games[g].numInputs + games[g].numOutputs; i++) {
            printf("%c ", 'A'+i);
        }
        printf("\n");

        for (e = 0; e < games[g].numEntries; e++) {
            for (i = 0; i < games[g].numInputs; i++) {
                printf("%d ", games[g].input[e][i]);
            }
            for (o = 0; o < games[g].numOutputs; o++) {
                printf("%d ", games[g].output[e][o]);
            }
            printf("\n");
        }
    }
}

void guessTheCircuit()
{
    difficultyLevel = selectDifficulty();
}

int main (void)
{
    char c;

    readDataFile(LEVELS);

    while (1) {
        clearScreen();

        printf("The Boolean Game\n");
        printf("================\n");
        printf("1. Overview.\n");
        printf("2. Tutorial.\n");
        printf("3. Play Fill in the Truth Table.\n");
        printf("4. Play Guess the Circuit.\n");
        printf("5. Quit.\n");

        printf("Selection? ");

        while (1) {
#ifdef __CC65__
            c = cgetc();
#else
            c = getchar();
#endif
            if (c >= '1' && c <= '5') {
                break;
            } else {
                beep();
            }
        }

        switch (c) {
        case '1':
            showFile(OVERVIEW);
            break;
        case '2':
            showFile(TUTORIAL);
            break;
        case '3':
            fillInTruthTable();
            break;
        case '4':
            guessTheCircuit();
            break;
        case '5':
            clearScreen();
            return EXIT_SUCCESS;
            break;
        }
    }
}
