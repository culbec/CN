function binaryRepr = numToBinary(num)
    % Converts a floating-point number (integers too) into its binary
    % representation
    % num -> the number to convert

    % Conversion table for decimal to hex
    cTable = dec2bin(0:15); % column wise

    % Converting the number to its binary representation
    hexRepr = num2hex(num);
    binRepr = cTable(hex2dec(hexRepr')+1,:)'; % row wise
    binRepr = binRepr(:)';

    % Result depends on the length of the binary representation
    switch length(binRepr)
        case 32
            binaryRepr = [binRepr(1), ",", binRepr(2:9), ",", binRepr(10:32)];
        case 64
            binaryRepr = [binRepr(1), ",", binRepr(2:12), ",", binRepr(13:64)];
        otherwise
            error('Format with length %d cannot be interpreted', length(binRepr));
    end
end