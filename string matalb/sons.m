Fs=44100
Ts=1/Fs
f=110
f_fund=440
delay=round(Fs/f)
t_final=4

t_intervalo=linspace(0,t_final,Fs*t_final)
note=zeros(Fs*t_final,1)


note_names=["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
%Nota kinda nice
for m=0:7
    for ex=0:11
        for k=1:(Fs*t_final)
            t=t_intervalo(k);
            f_fund=32.70*(2^m)*(2)^(ex/12);
            f=f_fund+cos(2*pi*20*f_fund);
            note(k)=0;
            
            func=10^(-2-(25/2000)/20*f);
            %g=(t*exp(0.2-t^(2)));
            g=(t*exp(0.2-t^(1)));
            note(k)= note(k)+func*g*cos(2*pi*f*t);
            for n=1:7
                func=10^(-2-(25/2000)/20*f*n);
                %g=(t*exp(0.2-n*t^(1)))*cos(pi*n/2)*10^(floor(log2(n)));
                g=(t*exp(0.2-n*t^(1)))*10^(floor(log2(n))/(m+1)^0.5);
                note(k)= note(k)+func*g*cos(2*pi*f*n*t);
            end
        end
        note = note-mean(note);
        note = note/max(abs(note));
        s=strcat("notes_add/sons_addsynth1_",num2str(f_fund),"_",note_names(ex+1),num2str(m+1),"_v1",".wav")
        audiowrite(s,note,Fs)
        %sound(note,Fs)
    end
end



