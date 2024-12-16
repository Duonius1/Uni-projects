#ifndef PASSWORD_MANAGER_H
#define PASSWORD_MANAGER_H

#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <regex>
#include <vector>
#include <iterator>
#include <algorithm>

using namespace std;

class Encoder {
private:
    const string encodings[7] = {
        "alsodkeirnfjcdnsmqueyrtmnbvcxzlpoiuytredsnajkdqwertufidhcnvbdjskeowivmclkjhgfdsaqwertyuiopbvd", // lowerCase
        "GPWIVMKFITHBQPWOEIRUTYLAKSJDHFGZMXNCBVNCJSIWHRYFHCNXMZKALSOQIWUEURNGJDPQOPSOPFNKMBMOPMSZKMOGN", // upperCase
        "102980859086075450698908109238098439857896700123984907295708679457310703198534701575404398574", // numbers
        "kUhTqWeFgVbNmkLjhFdcXdXdsRtYuIiOpLkGdsAqSfGhJklMnbvCxDrGtHuJiKoPlkjhgFdSdAqAzxCvVbnNmMkJhGfRw", // lowerCase + upperCase
        "6s8d9g0y0t9r7e6c8v9b0n8v6c5x4s7n3j2d0avm48xx4mmz4a4d76p5op3q2op1we3mxz4bi6q7eri4g7obr345enq5z", // lowerCase + numbers
        "1P2WE0I9P8R1TIUO23IALD0FS4753KH21S2J9D875GHMNI2H1IQ9P8Q6P23O3I43K2D1NL43V00K98S76B354D43VBNBV", // upperCase + numbers
        "Q6Es8TdU9IgP0LyKH0tB9Vr7CeX6c8Zv94DbiG6qH7JdfeKriY4GgFdB7gRoEBhbWrd3F4C5se7NSd7nMqg6DDMg5zFUG"  // lowerCase + upperCase + numbers
    };

public:
    string encode(string password, int length, int id);
};

class Decoder {
public:
    string decode(vector<int> positions);
};

class FileManager {
private:
    const string filename = "pass.txt";

public:
    int get_id_from_row(string file_row);
    void save_to_file_at(string password, int id, string paskirtis, int position_index);
    string get_encoded_from_row(string file_row);
    string get_purpose_from_row(string file_row);
    vector<int> get_positions(string password);
    void save_to_file_end(string password, int id, string paskirtis, string encoded);
    void remove_row_from_file(int position_index);
    int get_file_rows_count();
    const string getFileName();
    vector<int> get_positions_from_row(string file_row);
    string read_from_file(int line_id);
};

class PasswordManager {
private:
    PasswordManager() {}
public:
    Encoder encoder;
    Decoder decoder;
    FileManager fileManager;

    PasswordManager(const PasswordManager&) = delete;
    PasswordManager& operator=(const PasswordManager&) = delete;

    static PasswordManager& getInstance()
    {
        static PasswordManager instance;
        return instance;
    }

    int valid_password(string password);
};

#endif
