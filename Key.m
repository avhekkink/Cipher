classdef Key
    properties
        perm                        %stores the key as a permutation on the numbers 1 to 26
    end
    
    methods
        function a = Key(p)         %constructor method to store the permutation as its perm property
            
            if nargin==0                    %sets the perm as a random permutation if no input is given
                a.perm = randperm(26);
            elseif  isnumeric(p)==1         %stores the inputted number permutation as its perm property
                if length(p)~=26
                    error('input is not an acceptable length')
                else
                    a.perm = p;
                end
            elseif  ischar(p)==1            %stores the inputted character array as a permutation of numbers in the perm property
                if length(p)~=26
                    error('input is not an acceptable length')
                else
                    q = upper(p);
                    r = double(q)-64;
                    a.perm = r;
                end
            else
                error('input is not an acceptable form')
            end
            
        end
        
        function disp(a)            %displays the permutation of numbers as a permutation of the alphabet
            disp(char(a.perm+64))
        end
        
        function d = mtimes(l,m)    %composes two permutations l and m
            x = 1:26;
            for i = 1:26
                x(i) = m.perm(i);
            end
            y = x;
            for j = 1:26
                y(j) = l.perm(x(j));
            end
            d = Key(y);
        end
        
        function e = invert(k)      %inverts the key k
            x = 1:26;
            for i = 1:26
                x(k.perm(i)) = i;
            end
            e = Key(x);
        end
        
        function f = encrypt(k,m)       %encrypts the message m, with the key k
            q = upper(m);
            r = double(q);
            for i=1:length(r)           %for loop to encrypt each character code
                if r(i)>64 && r(i)<91   %only encrypts the char codes which correspond to letters
                    s(i) = r(i)-64;
                    x = k.perm;
                    t(i) = x(s(i));
                    u(i) = t(i)+64;
                    f(i) = char(u(i));  %converts the encrypted character codes back to a string
                else
                    f(i) = char(r(i));  %leaves non-letter characters unchanged
                    
                end
            end
        end
        
        function g = decrypt(k,m)       % decrypts a secret message m, with a key k
            x = k.invert;
            g = encrypt(x,m);
        end
        
        function h = swap(k,A,B)        %swaps A and B in the key k, to produce an improved key
            a = upper(A);
            b = double(a);
            c = b - 64;
            
            d = upper(B);
            e = double(d);
            f = e - 64;
            
            x = k.perm(c);
            y = k.perm(f);
            
            n = k.perm;
            n(c) = y;
            n(f) = x;
            
            h = Key(n);
        end
        
    end
end