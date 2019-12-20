classdef Attack
    
    properties
        ciphertext      %stores the encrypted message
        key             %stores a Key object
        past
    end
    
    
    methods
        function a = Attack(m)  %initiatlises the class
            a.ciphertext = m;   %sets the ciphertext as the original message
            a.key = Key(1:26);  %sets the initial key as the identity permutation, i.e. the alphabet
            a.past = List;      %sets up a.past as an empty list
        end
        
        function disp(a)
            disp('Key:')                    %displays the current key
            disp(a.key);
            disp(char(13));
            disp('Partial decoding:')       %displays the first 300 characters of the partially decoded message
            if length(a.ciphertext)<=300
                d = decrypt(a.key, a.ciphertext);
            else
                d = decrypt(a.key, a.ciphertext(1:300));
            end
            disp(d);
        end
        
        function b = lettercount(a)         %counts occurances of each letter in the ciphertext
            p = 1:26;
            x = upper(a.ciphertext);
            y = double(x);
            z = y-64;
            for i = 1:26
                p(i)=length(z(z==i));
            end
            b=p;
        end
        
        function c = attack(a)                  %guesses new key based on frequency of letters
            x = 'ZQXJKVBPYGFWMUCLDRHSNIOATE';   %alphabet in order of letter frequency
            y = double(x) - 64;
            z = Key(y);
            
            p = lettercount(a);
            q = permutation(p);
            r = Key(q);                         %ordered alphabet by frequency from the coded message
            
            m = 1:26;
            for i = 1:26
                m(z.perm(i))=r.perm(i);         %combines the two permutations to create the new key
            end
            
            k = Key(m);
            
            a.key = k;              %saves the new key, but leaves the original ciphertext the same
            a.past = List;          %restores a.past to the empty list
            c = a;                  %outputs the new key with the partially decoded message
            
        end
        
        function d = sample(a)              %outputs a patially decoded random 300 character sample from the ciphertext
            m = length(a.ciphertext);
            n = m-299;                      %ensures the sample is not cut short by reaching the end of the text
            o = randi(n);
            p = a.ciphertext(o:o+299);
            q = decrypt(a.key, p);          %decrypts the chosen sample
            
            d = q;
        end
        
        function e = swap(a,A,B)            %swaps the specified letters A, B in the current key
            k = a.key;
            n = swap(k,A,B);
            
            a.key = n;                      %updates the the new key
            p = [A,B];
            a.past=List(p,a.past);          %stores the swapped letters in a.past to enable an undo function
            e = a;
        end
        
        function f = undo(a)                %re-swaps the last two swapped letters to undo that move
            if isNil(a.past)==1             %checks if there are any moves to undo
                disp('No undo information')
                f = a;
            else
                A = a.past.head(1);
                B = a.past.head(2);
                k = a.key;
                n = swap(k,A,B);            %re-swaps the last two swapped letters back to where they were
                
                a.key = n;                  %updates the key after the swap has been undone
                a.past = a.past.tail;       %removes the undo move from a.past
                f = a;
            end
        end
    end
end

