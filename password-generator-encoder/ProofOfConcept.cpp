
    srand(time(0));
    string password = "";
    const string alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

    for (int i = 0; i < length; ++i)
    {
        int index = rand() % alphabet.length();
        password += alphabet[index];
    }

    return password;
}

int main() {
    int length;
    cout << "Enter the length of the password: ";
    cin >> length;

    string password = generatePassword(length);

    cout << "Generated password: " << password << endl;
    password = encode(password);
    cout << "Encoded password: " << password << endl;
    password = decode(password);
    cout << "Decoded password: " << password;
    return 0;
}
