include `C/C++`;

pattern SocketInputStreamP {
    classType {
        .kind==`class`;
        .mangledName=="SocketInputStream";
        .identifier=="SocketInputStream";
    }
};

function insideForloop(n:astnode) : bool ->
    if n.parent matches NonNull as p then
        if p matches forLoopSimple then
            true
        else
            insideForloop(p)
        endif
    else
        false
    endif

pattern SocketInputStreamReadP {
    functionCall {
        .calledFunction == functionSymbol {
            .identifier == "Read";
            .explicitParameterCount == 2;
            .functionType == functionType {
                .isMemberFunction == true;
            };
            .hasThis == true;
            .ownerClass == SocketInputStreamP;
        };
    }
};

pattern SIReadInLoopP {
    SocketInputStreamReadP as r where insideForloop(r)
};

check
{
    name = "socketinputstream read may overrun";
    reports = 
    for code in globalset allFunctionCode where code matches SIReadInLoopP : {
        events = [
            {
               description = "socketinputstream read in loop, may overrun"; 
               location = code.location;
            }
        ];
    }
};