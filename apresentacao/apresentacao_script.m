fs=44100
Ts=1/44100

%Wah effect
fc=3000;
F=2*sin((pi*fc)/fs);
Q=2*0.05;
%Fuzz - Usar Karplus-Strong Algorithm
%sound(note./max(note).*(1-exp(22*note.^2./max(note))),fs)

%Karplus +
beta=1/3; %pick position
N=1000; %2*string lengh in samples

%Produce Note
%sound_data=sim("apresentacao.slx",6)
%note=sound_data.simout.Data;

    %Para audio file
    %%{
    sound_data=sim("apresentacao.slx",14)
    note=sound_data.simout.Data;
    if( ndims(size(sound_data.simout.Data))==3)
            note=sum(note,1);
            note=squeeze(note);
    end
    

    %%}

note = note-mean(note);
note = note/max(abs(note));
sound(note,fs)
