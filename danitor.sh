# Caesar ciphering, for ciphering It. Don't encrypt things like this, kids!!!'
# The good thing Is that you can very easily just swap the key that's by default 4 to something more main-stream like a 7'


caesar_cipher() {
    local input="$1"
    local key=4
    local result=""


    for (( i=0; i<${#input}; i++ )); do
        char="${input:i:1}"


        if [[ "$char" =~ [a-z] ]]; then

            shifted=$(printf "%d" "'$char")
            shifted=$((shifted + key))


            if (( shifted > 122 )); then
                shifted=$((shifted - 26))
            fi

            result+=$(printf "\\$(printf %o $shifted)")


        elif [[ "$char" =~ [A-Z] ]]; then

            shifted=$(printf "%d" "'$char")
            shifted=$((shifted + key))


            if (( shifted > 90 )); then
                shifted=$((shifted - 26))
            fi

            result+=$(printf "\\$(printf %o $shifted)")

        else

            result+="$char"
        fi
    done

    echo "$result"
}

# This is the caesar decipher, helps with reading the files
caesar_decipher() {
    local input="$1"
    local key=4
    local result=""


    for (( i=0; i<${#input}; i++ )); do
        char="${input:i:1}"


        if [[ "$char" =~ [a-z] ]]; then

            shifted=$(printf "%d" "'$char")
            shifted=$((shifted - key))

            # Wrap around if necessary
            if (( shifted < 97 )); then
                shifted=$((shifted + 26))
            fi

            result+=$(printf "\\$(printf %o $shifted)")


        elif [[ "$char" =~ [A-Z] ]]; then

            shifted=$(printf "%d" "'$char")
            shifted=$((shifted - key))


            if (( shifted < 65 )); then
                shifted=$((shifted + 26))
            fi

            result+=$(printf "\\$(printf %o $shifted)")

        else
         
            result+="$char"
        fi
    done

    echo "$result"
}

echo "Enter file name without extension:"
read filename

filename="${filename}.dan"

echo "Save - CTRL + D"
input_text=$(cat)


ciphered_text=$(caesar_cipher "$input_text")


echo "$ciphered_text" > "$filename"

echo "Your text has been saved to $filename."


read_dan_file() {
    echo "Enter the name of the .dan file to read without the extention"
    read read_filename

    read_filename="${read_filename}.dan"

    if [[ -f "$read_filename" ]]; then
        file_content=$(cat "$read_filename")
        deciphered_text=$(caesar_decipher "$file_content")
        echo "Deciphered content of $read_filename:"
        echo "$deciphered_text"
    else
        echo "File $read_filename does not exist."
    fi
}


echo "Would you like to read a .dan file? (y/n)"
read read_choice

if [[ "$read_choice" == "y" ]]; then
    read_dan_file
fi

