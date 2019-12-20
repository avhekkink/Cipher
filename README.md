# Cipher
First year project where the aim was to decrypt a cipher text using an attack algorithm to determine the key used to encrypt the original text.

The ciphertext file contains the 'Secret' which we aim to decrypt.

The attack file contains the code we use to systematically work out the key. It begins by guessing the key initally by calculating the frequency of each letter used in the cipher text, and comparing these to the known order of letters most used in the alphabet. From this initial guess, the program allows the user to swap letters in the key when they begin to recognise words in the cipher text. Note that this code shows just a 300 word passage for the user to work with, instead of displaying the entire text. The user can continue swapping letters until the final key is worked out and the cipher text makes perfect sense.

The Key file contains the functions needed to edit the key as the user swaps letters, as well as the methods to decrypt the sample text with the current key.

The solution file contains the specific key that decrypts the 'Secret' in our ciphertext. It turns out that the secret was a passage taken from a Sherlock Holmes book.


-Coded in MATLAB
