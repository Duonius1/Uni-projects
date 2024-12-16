## PassGen
Program that encodes user's passwords by "selecting" a few parameters, which get assigned a name so you can decode it later.

Program functionality:

	You can create a password, choose it's length, choose where it's used and choose the encoding (symbols, numbers, etc.)
	You can also view created passwords, you can change them, delete them as well as decode them.
	All of these points above have validation to make sure the program doesn't break.
	The passwords themselves are stored in pass.txt

Program functions:

	get_id_from_row: Retrieves the ID number from a row in the file.
	save_to_file_at: Saves data to a specific position in the file.
	get_encoded_from_row: Retrieves the encoded password from a row in the file.
	get_purpose_from_row: Retrieves the purpose (password usage target) from a row in the file.
	get_positions: Returns the vector of password positions.
	save_to_file_end: Saves data to the end of the file.
	remove_row_from_file: Removes a row from the file based on its position.
	get_file_rows_count: Returns the number of rows in the file.
	getFileName: Returns the file name.
	get_positions_from_row: Retrieves the vector of positions from a row in the file.
	read_from_file: Reads data from the file based on a row number.
	PasswordManager: This is a singleton class that encompasses all other management components (Encoder, Decoder, and FileManager).
	It has the valid_password function, which checks whether a password is valid (i.e., has no spaces). 
	The singleton class is useful because it provides global access to all key parts of the program from anywhere, such as encoding/decoding functions and the file manager.
