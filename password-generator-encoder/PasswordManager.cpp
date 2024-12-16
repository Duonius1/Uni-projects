#include "PasswordManager.h"


string Encoder::encode(string password, int length, int id) {
    string encoded;
    for (int i = 0; i < length; ++i) {
        int num = static_cast<int>(password[i % (password.length() - 1)]) - 33;
        char symbol = encodings[id][num];
        encoded.push_back(symbol);
    }
    return encoded;
}

string Decoder::decode(vector<int> positions) {
    string decoded;
    int original_length = positions.size();

    for (int i = 0; i < original_length; ++i) {
        int ascii = positions.at(i) + 33;
        char symbol = static_cast<char>(ascii);
        decoded.push_back(symbol);
    }

    return decoded;
}

int FileManager::get_id_from_row(string file_row) {
    regex regex("^(?:[^;]*;){1}([^;]+)");
    smatch match;
    if (!regex_search(file_row, match, regex)) {
        return 0;
    }
    string id = match[1];
    return stoi(id);
}

void FileManager::save_to_file_at(string password, int id, string paskirtis, int position_index) {
    vector<int> positions = get_positions(password);

    ifstream infile(filename);
    if (!infile) {
        cerr << "Nepavyko atidaryti failo: " << filename << endl;
        return;
    }

    vector<string> lines;
    string line;
    while (getline(infile, line)) {
        lines.push_back(line);
    }
    infile.close();

    if (position_index >= 0 && position_index <= static_cast<int>(lines.size())) {
        string new_data;
        for (size_t i = 0; i < positions.size(); ++i) {
            int position = positions[i];
            new_data += to_string(position) + " ";
        }
        new_data += ";" + to_string(id) + ";" + paskirtis;
        lines[position_index] = new_data;
    } else {
        cerr << "Paduotas blogas pozicijos indeksas" << endl;
        return;
    }

    ofstream outfile(filename);
    if (!outfile) {
        cerr << "Nepavyko atidaryti failo: " << filename << endl;
        return;
    }

    for (size_t i = 0; i < lines.size(); ++i) {
        const string& line = lines[i];
        outfile << line << endl;
    }
    outfile.close();
}

string FileManager::get_encoded_from_row(string file_row) {
    regex pattern("^(?:[^;]*;){3}([^;]+)");
    smatch match;

    (regex_search(file_row, match, pattern));
    return match.size() > 1 ? match.str(1) : "";
}

string FileManager::get_purpose_from_row(string file_row) {
    regex pattern("^(?:[^;]*;){2}([^;]+)");
    smatch match;
    regex_search(file_row, match, pattern);
    return match.size() > 1 ? match.str(1) : "";
}

vector<int> FileManager::get_positions(string password) {
    vector<int> positions;

    int password_length = password.length();
    for (int i = 0; i < password_length; ++i) {
        int num = static_cast<int>(password[i % (password.length() - 1)]) - 33;
        positions.push_back(num);
    }

    return positions;
}

void FileManager::save_to_file_end(string password, int id, string paskirtis, string encoded) {
    vector<int> positions = get_positions(password);

    ofstream outfile(filename, ios::app);
    if (!outfile) {
        cerr << "Nepavyko atidaryti failo: " << filename << endl;
        return;
    }

    copy(positions.begin(), positions.end(), ostream_iterator<int>(outfile, " "));

    outfile << ";" << id << ";" << paskirtis << ";" << encoded << endl;
    outfile.close();
}

void FileManager::remove_row_from_file(int position_index) {
    ifstream infile(filename);
    if (!infile) {
        cerr << "Nepavyko atidaryti failo: " << filename << endl;
        return;
    }

    vector<string> lines;
    string line;
    while (getline(infile, line)) {
        lines.push_back(line);
    }
    infile.close();

    ofstream outfile(filename);
    if (!outfile) {
        cerr << "Nepavyko atidaryti failo: " << filename << endl;
        return;
    }

    for (size_t i = 0; i < lines.size(); ++i) {
        if (static_cast<int>(i) == position_index) {
            continue;
        }
        const string& line = lines[i];
        outfile << line << endl;
    }
    outfile.close();
}

int FileManager::get_file_rows_count() {
    ifstream file(filename);
    if (!file.is_open()) {
        cerr << "Nepavyko atidaryti failo: " << filename << endl;
        return -1;
    }

    int count = 0;
    string line;
    while (getline(file, line)) {
        ++count;
    }

    file.close();
    return count;
}

const string FileManager::getFileName() {
    return filename;
}

vector<int> FileManager::get_positions_from_row(string file_row) {
    vector<int> result;
    regex regex(";");
    smatch match;
    if (!regex_search(file_row, match, regex)) {
        return result;
    }
    string positions_row = match.prefix();
    istringstream iss(positions_row);
    int num;

    while (iss >> num) {
        result.push_back(num);
    }

    return result;
}

string FileManager::read_from_file(int line_id) {
    ifstream infile(filename);
    if (!infile) {
        cerr << "Nepavyko atidaryti failo: " << filename << endl;
        return "";
    }
    string line;

    int current_line_id = 0;
    while (getline(infile, line)) {
        if (current_line_id == line_id) {
            break;
        }
        current_line_id++;
    }

    infile.close();
    return line;
}

int PasswordManager::valid_password(string password) {
    int password_length = password.length();
    for (int i = 0; i < password_length; ++i) {
        if (password[i] == ' ') {
            return false;
        }
    }
    return true;
}
