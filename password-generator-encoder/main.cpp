#include "PasswordManager.h"
#include <cassert>

void testEncoder() {
    Encoder encoder;

    // Testuojamas uzkodavimas su ivairiais ilgiais ir kodavimo budais
    string password1 = "hello123*%@";
    int length1 = password1.length() + 5;
    int id1 = 6; // lowerCase + upperCase + numbers
    assert(encoder.encode(password1, length1, id1) == "5FNN7H0tI85FNN7H"); // Tikimasi teisingai uzkoduoto slaptazodzio
    string password2 = "hello123*%@";
    int length2 = password1.length() + 7;
    int id2 = 2; // numbers
    assert(encoder.encode(password2, length2, id2) == "305575060830557506"); // Tikimasi teisingai uzkoduoto slaptazodzio
    string password3 = "hello123*%@";
    int length3 = password1.length() + 1;
    int id3 = 4; // lowerCase + numbers
    assert(encoder.encode(password3, length3, id3) == "bx77i8v9t9bx"); // Tikimasi teisingai uzkoduoto slaptazodzio
}

void testDecoder() {

    Decoder decoder;

    // Testuojamas dekodavimas su ivairiu poziciju vektoriais
    vector<int> positions1 = {44, 72, 77, 67, 64, 84, 70, 64, 82}; // Lygus "Mindaugas"
    assert(decoder.decode(positions1) == "Mindaugas"); // Tikimasi teisingai dekoduoto slaptazodzio

    vector<int> positions2 = {45, 72, 74, 64, 82}; // Lygus "Nikas"
    assert(decoder.decode(positions2) == "Nikas"); // Tikimasi teisingai dekoduoto slaptazodzio

    vector<int> positions3 = {53, 64, 75, 67, 68, 76, 64, 81}; // Lygus "Valdemar"
    assert(decoder.decode(positions3) == "Valdemar"); // Tikimasi teisingai dekoduoto slaptazodzio

    vector<int> positions4 = {71, 68, 75, 75, 78, 86, 78, 81, 75, 67, 16, 17, 18}; // Lygus "helloworld123"
    assert(decoder.decode(positions4) == "helloworld123"); // Tikimasi teisingai dekoduoto slaptazodzio

}

void testFileManager() {
    FileManager fileManager;

    // Testuojamas saugojimas i faila ir tada skaitymas is tos pozicijos
    fileManager.save_to_file_at("test123", 1, "testas", 0);
    assert(fileManager.read_from_file(0) == "83 68 82 83 16 17 83 ;1;testas");

    fileManager.save_to_file_at("7p#K*3@q97", 2, "kitas testas", 1);
    assert(fileManager.read_from_file(1) == "22 79 2 42 9 18 31 80 24 22 ;2;kitas testas");

    // Testuojamas ID gavimas is eilutes
    string fileRow1 = "16 4 18 19 25 ;1;test purpose";
    assert(fileManager.get_id_from_row(fileRow1) == 1);

    // Testuojamas gavimas uzkoduoto slaptazodzio is eilutes
    string fileRow2 = "16 4 18 19 25 ;1;test purpose;5FNN7H0tI85FNN7H";
    assert(fileManager.get_encoded_from_row(fileRow2) == "5FNN7H0tI85FNN7H");

    // Testuojamas gavimas slaptazodzio pavadinimo
    string fileRow3 = "16 4 18 19 25 ;1;test purpose;5FNN7H0tI85FNN7H";
    assert(fileManager.get_purpose_from_row(fileRow3) == "test purpose");
}

void testPasswordManager() {
    PasswordManager& manager = PasswordManager::getInstance();

    // Test valid password validation
    assert(manager.valid_password("hello123*%@") == true);
    assert(manager.valid_password("invalid password with space") == false);

}
int main() {

    PasswordManager& manager = PasswordManager::getInstance();

    string password = "hello123*%@";
    int length = password.length() + 5;
    int id = 6; // lowerCase + upperCase + numbers
    string paskirtis = "mokyklos slaptazodis";

    string encoded = manager.encoder.encode(password, length, id);
    manager.fileManager.save_to_file_end(password, id, paskirtis, encoded);

    if(manager.fileManager.get_file_rows_count() > 0)
    {
        string file_row = manager.fileManager.read_from_file(0);
        vector <int> positions = manager.fileManager.get_positions_from_row(file_row);
        string decoded = manager.decoder.decode(positions);

        cout << encoded << endl;
        cout << decoded << endl;

        cout << "id = " << manager.fileManager.get_id_from_row(file_row) << endl;
        cout << "paskirtis = " << manager.fileManager.get_purpose_from_row(file_row) << endl;
        cout << "uzkoduotas = " << manager.fileManager.get_encoded_from_row(file_row) << endl;

    }

  if (manager.valid_password("negali buti space") || !manager.valid_password("be_space")) {
    cout << "kazkas blogai su validacija" << endl;
  }

    testEncoder();
    cout << "Visi Uzkodavimo testai sekmingai praejo\n\n";
    testDecoder();
    cout << "Visi Dekodavimo testai sekmingai praejo\n\n";
    testPasswordManager();
    cout << "Visi PasswordManager testai sekmingai praejo\n\n";
    testFileManager();
    cout << "Visi FileManager testai sekmingai praejo";

    return 0;
}
